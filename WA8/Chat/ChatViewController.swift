//
//  ChatViewController.swift
//  WA8
//
//  Created by Sai Vihar Reddy Gunamgari on 11/3/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    let chatView = ChatView()
    var chat: Chat?
    var participants: [User] = []
    var messages = [Message]()
    
    let db = Firestore.firestore()
    
    var currentUID: String {
        return Auth.auth().currentUser!.uid
    }
    
    override func loadView() {
        view = chatView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatView.messagesTableView.delegate = self
        chatView.messagesTableView.dataSource = self
        chatView.messagesTableView.rowHeight = UITableView.automaticDimension
        chatView.messagesTableView.estimatedRowHeight = 60
        chatView.sendMsgButton.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
        
        if let chat = chat {
            title = chatTitle(chat: chat)
            listenForMessages()
        } else {
            title = chatTitleForNewChat()
        }
    }
    
    func chatTitle(chat: Chat) -> String {
        var displayNames: [String] = []
        for (index, uid) in chat.with.enumerated() {
            if uid != currentUID, index < chat.withNames.count {
                displayNames.append(chat.withNames[index])
            }
        }
        return displayNames.isEmpty ? "You" : displayNames.joined(separator: ", ")
    }
    
    func chatTitleForNewChat() -> String {
        let displayNames = participants.compactMap { $0.name }
        return displayNames.joined(separator: ", ")
    }
    
    @objc func sendTapped() {
        guard let text = chatView.sendMsgTextField.text, !text.isEmpty else { return }
        
        if let chat = chat {
            sendMsgToExistingChat(chatId: chat.chatId!, text: text)
        } else {
            createChatAndSendFirstMessage(text: text)
        }
        chatView.sendMsgTextField.text = ""
    }
    
    func createChatAndSendFirstMessage(text: String) {
        var withIds = participants.compactMap { $0.uid }
        withIds.append(currentUID)
        
        var withNames = self.participants.map { $0.name }
        withNames.append(UserSession.shared.currentUser!.name)

        let chatRef = self.db.collection("chats").document()
        let chatData: [String: Any] = [
            "with": withIds,
            "withNames": withNames,
            "lastMessage": text,
            "lastSender": self.currentUID,
            "lastUpdated": Timestamp()
        ]

        chatRef.setData(chatData) { error in
            guard error == nil else { return }
            chatRef.getDocument { docSnapshot, error in
                guard let doc = docSnapshot,
                      let chat = try? doc.data(as: Chat.self)
                else { return }
                self.chat = chat
                self.listenForMessages()
                self.sendMsgToExistingChat(chatId: chat.chatId!, text: text)
            }
        }
    }

    
    func sendMsgToExistingChat(chatId: String, text: String) {
        let msgRef = db.collection("chats").document(chatId)
            .collection("messages").document()
        let now = Timestamp()

        let msgData: [String: Any] = [
            "text": text,
            "senderId": currentUID,
            "senderName": UserSession.shared.currentUser!.name,
            "timestamp": now
        ]

        msgRef.setData(msgData) { error in
            if let error = error {
                print("Error writing message: \(error)")
            } else {
                self.db.collection("chats").document(chatId).updateData([
                    "lastMessage": text,
                    "lastSender": self.currentUID,
                    "lastUpdated": now
                ])
            }
        }
    }
    
    func listenForMessages() {
        guard let chatId = chat?.chatId else { return }

        db.collection("chats").document(chatId)
            .collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener { snapshot, error in
                guard let docs = snapshot?.documents else { return }
                self.messages = docs.compactMap { try? $0.data(as: Message.self) }

                DispatchQueue.main.async {
                    self.chatView.messagesTableView.reloadData()
                    self.scrollToBottom()
                }
            }
    }
    
    func scrollToBottom() {
        guard messages.count > 0 else { return }
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        chatView.messagesTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentUId = Auth.auth().currentUser!.uid
        let message = messages[indexPath.row]
        
        if message.senderId == currentUId {
            let cell = tableView.dequeueReusableCell(withIdentifier: "outgoingMsgs", for: indexPath) as! OutgoingMsgCell
            cell.messageLabel.text = message.text
            cell.timeLabel.text = message.timestamp.formattedTime()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "incomingMsgs", for: indexPath) as! IncomingMsgCell
            cell.senderLabel.text = message.senderName
            cell.messageLabel.text = message.text
            cell.timeLabel.text = message.timestamp.formattedTime()
            return cell
        }
    }
    
    
}

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
        chatView.messagesTableView.estimatedRowHeight = 44
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
        print("checkpoint 1")
        var withIds = participants.map { $0.uid }
        withIds.append(currentUID)
        
        db.collection("users").document(currentUID).getDocument { snapshot, error in
            print("checkpoint 2")
            guard let data = snapshot?.data(), let currentUserName = data["name"] as? String else { return }
            
            var withNames = self.participants.map { $0.name }
            withNames.append(currentUserName)
            
            let chatRef = self.db.collection("chats").document()
            let chatData: [String: Any] = [
                "with": withIds,
                "withNames": withNames,
                "lastMessage": text,
                "lastSender": self.currentUID,
                "lastUpdated": Timestamp()
            ]
            
//            chatRef.setData(chatData) { error in
//                print("checkpoint 3")
//                guard error == nil else { return }
//                chatRef.getDocument { docSnapshot, error in
//                    print("checkpoint 4")
//                    guard let doc = docSnapshot,
//                          let chat = try? doc.data(as: Chat.self) else { return }
//                    self.chat = chat
//                    self.listenForMessages()
//                    self.sendMsgToExistingChat(chatId: chat.chatId!, text: text)
//                }
//            }
            chatRef.setData(chatData) { error in
                print("checkpoint 3")
                guard error == nil else { return }
                chatRef.getDocument { docSnapshot, error in
                    print("checkpoint 4")
                    guard let doc = docSnapshot else {
                        print("❌ No document snapshot")
                        return
                    }
                    do {
                        let chat = try doc.data(as: Chat.self)
                        print("✅ Chat decoded, id:", chat.chatId ?? "nil")
                        self.chat = chat
                        self.listenForMessages()
                        self.sendMsgToExistingChat(chatId: chat.chatId, text: text)
                    } catch {
                        print("❌ Failed to decode Chat:", error)
                        print("Raw data:", doc.data() ?? [:])
                    }
                }
            }
        }
    }
    
//    func sendMsgToExistingChat(chatId: String, text: String) {
//        let msgRef = db.collection("chats").document(chatId).collection("messages").document()
//        let now = Int64(Date().timeIntervalSince1970 * 1000)
//        let msgData: [String: Any] = [
//            "text": text,
//            "senderId": currentUID,
//            "timestamp": now
//        ]
//        msgRef.setData(msgData) { error in
//            if let error = error {
//                print("Error writing document: \(error)")
//            } else {
//                print("✅ Message written")
//                self.db.collection("chats").document(chatId).updateData([
//                    "lastMessage": text,
//                    "lastSender": self.currentUID,
//                    "lastUpdated": now
//                ])
//            }
//        }
//    }
    func sendMsgToExistingChat(chatId: String?, text: String) {
        guard let chatId = chatId else {
            print("❌ sendMsgToExistingChat: chatId is nil")
            return
        }

        let msgRef = db.collection("chats").document(chatId)
            .collection("messages").document()

        let msgData: [String: Any] = [
            "text": text,
            "senderId": currentUID,
            "timestamp": Timestamp() 
        ]

        print("➡️ Writing message to chatId=\(chatId)")
        msgRef.setData(msgData) { error in
            if let error = error {
                print("🔥 Error writing message: \(error)")
            } else {
                print("✅ Message written")
                self.db.collection("chats").document(chatId).updateData([
                    "lastMessage": text,
                    "lastSender": self.currentUID,
                    "lastUpdated": Timestamp()
                ])
            }
        }
    }
    
//    func listenForMessages() {
//        guard let chatId = chat?.chatId else {
//            print("❌ listenForMessages: chatId is nil")
//            return
//        }
//        
//        db.collection("chats").document(chatId).collection("messages").order(by: "timestamp")
//            .addSnapshotListener { snapshot, error in
//                guard let docs = snapshot?.documents else { return }
//                self.messages = docs.compactMap { try? $0.data(as: Message.self) }
//                
//                DispatchQueue.main.async {
//                    self.chatView.messagesTableView.reloadData()
//                    self.scrollToBottom()
//                }
//            }
//    }
    func listenForMessages() {
        guard let chatId = chat?.chatId else {
            print("❌ listenForMessages: chatId is nil")
            return
        }

        db.collection("chats").document(chatId)
            .collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("🔥 Listener error: \(error)")
                    return
                }
                guard let docs = snapshot?.documents else {
                    print("Listener: no documents")
                    return
                }
                print("🔍 Listener received \(docs.count) message docs")

                self.messages = docs.compactMap {
                    do {
                        return try $0.data(as: Message.self)
                    } catch {
                        print("Decode error for doc \($0.documentID): \(error)")
                        return nil
                    }
                }

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
            cell.messageLabel.text = message.text
            cell.timeLabel.text = message.timestamp.formattedTime()
            return cell
        }
    }
    
    
}

//
//  ChatsViewController.swift
//  WA8
//
//  Created by Sai Vihar Reddy Gunamgari on 11/2/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatsViewController: UIViewController {
    let chatsView = ChatsView()
    var chats = [Chat]()
    
    let db = Firestore.firestore()
    
    override func loadView() {
        view = chatsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Chats"
        chatsView.chatsTableView.delegate = self
        chatsView.chatsTableView.dataSource = self
        chatsView.chatsTableView.rowHeight = UITableView.automaticDimension
        chatsView.chatsTableView.estimatedRowHeight = 82
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .compose,
            target: self,
            action: #selector(createChatTapped)
        )
        
        fetchChats()
    }
    
    @objc func createChatTapped() {
        let createChatViewController = CreateChatViewController()
        createChatViewController.delegate = self
        let createChatNavigationController = UINavigationController(rootViewController: createChatViewController)
        createChatNavigationController.modalPresentationStyle = .pageSheet
        
        if let sheetPresentationController = createChatNavigationController.sheetPresentationController {
            sheetPresentationController.detents = [.large()]
            sheetPresentationController.prefersGrabberVisible = true
        }
        present(createChatNavigationController, animated: true)
    }
    
    func fetchChats() {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        db.collection("chats")
            .whereField("with", arrayContains: currentUser.uid)
            .order(by: "lastUpdated", descending: true)
            .addSnapshotListener { snapshot, error in
                guard let docs = snapshot?.documents else { return }
                
                let chats = docs.compactMap { try? $0.data(as: Chat.self) }
                self.chats = chats
                
                let hasChats = !chats.isEmpty
                self.chatsView.noChatsLabel.isHidden = hasChats
                self.chatsView.chatsTableView.isHidden = !hasChats
                self.chatsView.chatsTableView.reloadData()
            }
    }
}

extension ChatsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chats", for: indexPath) as! ChatsTableViewCell
        
        let chat = chats[indexPath.row]
        let currentUID = Auth.auth().currentUser!.uid
        let participants = zip(chat.with, chat.withNames)
            .filter { $0.0 != currentUID }
            .map { $0.1 }
        cell.nameLabel.text = participants.joined(separator: ", ")
        cell.timeLabel.text = chat.lastMsgTime
        cell.msgLabel.text = chat.lastSender == currentUID ? "You: \(chat.lastMsgPreview)" : chat.lastMsgPreview
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatViewController = ChatViewController()
        chatViewController.chat = chats[indexPath.row]
        navigationController?.pushViewController(chatViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let chatToDelete = chats[indexPath.row]
            guard let chatId = chatToDelete.chatId else { return }
            
            db.collection("chats").document(chatId).delete() { error in
                if let error = error {
                    print("Error deleting document: \(error)")
                } else {
                    print("Document deleted")
                }
            }
        }
    }
}

extension ChatsViewController: CreateChatViewControllerDelegate {
    func didSelectParticipants(_ participants: [User]) {
//        if participants.count == 1 {
            let selectedUIDs = participants.compactMap { $0.uid }
            fetchExistingChat(with: selectedUIDs) { existingChat in
                self.openChat(existingChat: existingChat, participants: participants)
            }
//        } else {
//            openChat(existingChat: nil, participants: participants)
//        }
    }
    
    func fetchExistingChat(with uids: [String], completion: @escaping (Chat?) -> Void) {
        guard let currentUserUID = Auth.auth().currentUser?.uid else { return }
        
        let allIds = (uids + [currentUserUID]).sorted()
        
        db.collection("chats").whereField("with", arrayContains: currentUserUID)
            .getDocuments { snapshot, error in
                guard let docs = snapshot?.documents else {
                    completion(nil)
                    return
                }
                for doc in docs {
                    if let chat = try? doc.data(as: Chat.self) {
                        let chatIdsSorted = chat.with.sorted()
                        if chatIdsSorted == allIds {
                            completion(chat)
                            return
                        }
                    }
                }
                completion(nil)
            }
    }
    
    func openChat(existingChat: Chat?, participants: [User]) {
        let chatViewController = ChatViewController()
        if let existingChat = existingChat {
            chatViewController.chat = existingChat
        } else {
            chatViewController.participants = participants
        }
        navigationController?.pushViewController(chatViewController, animated: true)
    }
}

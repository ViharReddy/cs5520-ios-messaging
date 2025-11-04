//
//  CreateChatViewController.swift
//  WA8
//
//  Created by Sai Vihar Reddy Gunamgari on 11/3/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

protocol CreateChatViewControllerDelegate: AnyObject {
    func didSelectParticipants(_ participants: [User])
}

class CreateChatViewController: UIViewController {
    let createChatView = CreateChatView()
    var users = [User]()
    
    var delegate: CreateChatViewControllerDelegate?
    
    let db = Firestore.firestore()
    
    override func loadView() {
        view = createChatView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "New Chat"
        
        createChatView.usersTableView.dataSource = self
        createChatView.usersTableView.delegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(dismissSelf)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Message",
            style: .plain,
            target: self,
            action: #selector(openNewChat)
        )
        
        fetchUsers()
    }
    
    @objc func dismissSelf() {
        dismiss(animated: true)
    }
    
    @objc func openNewChat() {
        guard let selectedIndexPaths = createChatView.usersTableView.indexPathsForSelectedRows else {
            dismissSelf()
            return
        }
        
        let selectedUsers = selectedIndexPaths.map { users[$0.row] }
        delegate?.didSelectParticipants(selectedUsers)
        dismissSelf()
    }
    
    func fetchUsers() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }

        db.collection("users").getDocuments( completion: { [weak self] snapshot, error in
            guard let self = self else { return }
            guard let docs = snapshot?.documents else { return }
            
            self.users = docs.compactMap { doc in
                let data = doc.data()
                let uid = doc.documentID
                let name = data["name"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                return uid == currentUid ? nil : User(uid: uid, name: name, email: email)
            }
            DispatchQueue.main.async {
                self.createChatView.usersTableView.reloadData()
            }
        })
    }
    
//    func createChat(with user: User) {
//        guard let currentUser = Auth.auth().currentUser else { return }
//        
//        db.collection("users").document(currentUser.uid).getDocument { [weak self] snapshot, error in
//            guard let self = self else { return }
//            guard let data = snapshot?.data(), let currentUsername = data["name"] as? String else {
//                return
//            }
//            db.collection("chats").whereField("with", arrayContains: currentUser.uid).getDocuments { [weak self] snapshot, error in
//                guard let self = self else { return }
//                guard let docs = snapshot?.documents else { return }
//                
//                if let existingDoc = docs.first(where: { doc in
//                    let chatWith = doc.data()["with"] as? [String] ?? []
//                    return chatWith.contains(currentUser.uid) && chatWith.contains(user.uid!)
//                }) {
//                    if let chat = try? existingDoc.data(as: Chat.self) {
//                        self.openChat(chat)
//                    }
//                    return
//                }
//                let newChat = Chat(
//                    with: [currentUser.uid, user.uid!],
//                    withNames: [currentUsername, user.name],
//                    lastUpdated: Int64(Date().timeIntervalSince1970 * 1000)
//                )
//                _ = try? db.collection("chats").addDocument(from: newChat) { error in
//                    if let error = error {
//                        print("Failed to create chat: \(error.localizedDescription)")
//                    } else {
//                        self.openChat(newChat)
//                    }
//                }
//            }
//        }
//    }
    
//    func openChat(_ chat: Chat) {
//        DispatchQueue.main.async {
//            let chatViewController = ChatViewController()
//            chatViewController.chat = chat
//            self.dismissSelf()
//            if let nav = self.presentingViewController as? UINavigationController {
//                nav.pushViewController(chatViewController, animated: true)
//            }
//        }
//    }
}

extension CreateChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "users", for: indexPath) as! UsersTableViewCell
        let user = users[indexPath.row]
        cell.nameLabel.text = user.name
        cell.emailLabel.text = user.email
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedUser = users[indexPath.row]
//        tableView.deselectRow(at: indexPath, animated: true)
//        createChat(with: selectedUser)
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}

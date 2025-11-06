//
//  ViewController.swift
//  WA8
//
//  Created by Sai Vihar Reddy Gunamgari on 10/31/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let chatsTab = UINavigationController(rootViewController: ChatsViewController())
        let chatsTabBarItem = UITabBarItem(
            title: "Chats",
            image: UIImage(systemName: "bubble.left.and.bubble.right"),
            selectedImage: nil
        )
        chatsTab.tabBarItem = chatsTabBarItem
        chatsTab.title = "Chats"
        
        let profileTab = UINavigationController(rootViewController: ProfileViewController())
        let profileTabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person.circle"),
            selectedImage: nil
        )
        profileTab.tabBarItem = profileTabBarItem
        profileTab.title = "Profile"
        
        self.viewControllers = [chatsTab, profileTab]
        
        self.delegate = self
        
        fetchUserDetails()
    }
    
    func fetchUserDetails() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("Error fetching user: \(error)")
                return
            }
            
            guard let user = try? snapshot?.data(as: User.self) else { return }
            UserSession.shared.currentUser = user
        }
    }

}

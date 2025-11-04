//
//  ProfileViewController.swift
//  WA8
//
//  Created by Sai Vihar Reddy Gunamgari on 11/2/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController {
    let profileView = ProfileView()
    
    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile"
        profileView.signoutButton.addTarget(self, action: #selector(signout), for: .touchUpInside)
        
        profileView.startLoading()
        setValues()
    }
    
    @objc func signout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out: \(error)")
        }
        
        let loginVC = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginVC)
        guard let window = view.window else { return }
        window.rootViewController = navigationController
    }
    
    func setValues() {
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser!.uid
        
        db.collection("users").document(uid).getDocument { document, error in
            self.profileView.stopLoading()
            if let document = document, document.exists {
                let data = document.data()!
                self.profileView.nameValueLabel.text = data["name"] as? String
                self.profileView.emailValueLabel.text = data["email"] as? String
            } else {
                print("Document does not exist")
            }
        }
    }

}

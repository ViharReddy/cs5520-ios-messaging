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
        profileView.nameValueLabel.text = UserSession.shared.currentUser?.name
        profileView.emailValueLabel.text = UserSession.shared.currentUser?.email
    }

}

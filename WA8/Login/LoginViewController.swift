//
//  LoginViewController.swift
//  WA8
//
//  Created by Sai Vihar Reddy Gunamgari on 11/2/25.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    let loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Login"
        
        loginView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        loginView.loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        loginView.signupButton.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        loginView.emailTextField.addTarget(self, action: #selector(handleInputChange), for: [.editingDidBegin, .editingChanged])
        loginView.passwordTextField.addTarget(self, action: #selector(handleInputChange), for: [.editingDidBegin, .editingChanged])
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func handleInputChange() {
        loginView.errorLabel.isHidden = true
    }
    
    @objc func handleLogin() {
        if let email = loginView.emailTextField.text,
           let password = loginView.passwordTextField.text {
            if email.isEmpty {
                loginView.errorLabel.text = "Email is required!"
                loginView.errorLabel.isHidden = false
                return
            } else if !Utilities.isValidEmail(email) {
                loginView.errorLabel.text = "Invalid email format!"
                loginView.errorLabel.isHidden = false
                return
            } else if password.isEmpty {
                loginView.errorLabel.text = "Password is required!"
                loginView.errorLabel.isHidden = false
                return
            }
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    self.loginView.errorLabel.text = error.localizedDescription
                    self.loginView.errorLabel.isHidden = false
                    return
                }
                
                DispatchQueue.main.async {
                    let viewController = ViewController()
                    guard let window = self.view.window else { return }
                    window.rootViewController = viewController
                }
            }
        }
    }
    
    @objc func handleSignup() {
        let signupViewController = SignupViewController()
        navigationController?.pushViewController(signupViewController, animated: true)
    }
}

//
//  SignupViewController.swift
//  WA8
//
//  Created by Sai Vihar Reddy Gunamgari on 11/2/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignupViewController: UIViewController {
    let signupView = SignupView()
    
    override func loadView() {
        view = signupView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Register Account"
        
        signupView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        signupView.signupButton.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        signupView.loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        signupView.emailTextField.addTarget(self, action: #selector(handleInputChange), for: [.editingDidBegin, .editingChanged])
        signupView.passwordTextField.addTarget(self, action: #selector(handleInputChange), for: [.editingDidBegin, .editingChanged])
        signupView.confirmPasswordTextField.addTarget(self, action: #selector(handleInputChange), for: [.editingDidBegin, .editingChanged])
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func handleInputChange() {
        signupView.errorLabel.isHidden = true
    }
    
    @objc func handleSignup() {
        if let nameText = signupView.nameTextField.text,
           let emailText = signupView.emailTextField.text,
           let passwordText = signupView.passwordTextField.text,
           let confirmPasswordText = signupView.confirmPasswordTextField.text {
            if nameText.isEmpty || emailText.isEmpty || passwordText.isEmpty || confirmPasswordText.isEmpty {
                signupView.errorLabel.text = "All fields are required."
                signupView.errorLabel.isHidden = false
                return
            } else if !Utilities.isValidEmail(emailText) {
                signupView.errorLabel.text = "Invalid email format."
                signupView.errorLabel.isHidden = false
                return
            } else if passwordText.count < 6 || confirmPasswordText.count < 6 {
                signupView.errorLabel.text = "Password must be at least 6 characters long."
                signupView.errorLabel.isHidden = false
                return
            } else if passwordText != confirmPasswordText {
                signupView.errorLabel.text = "Passwords do not match."
                signupView.errorLabel.isHidden = false
                return
            }
            
            Auth.auth().createUser(withEmail: emailText, password: passwordText) { authResult, error in
                if let error = error {
                    self.signupView.errorLabel.text = error.localizedDescription
                    self.signupView.errorLabel.isHidden = false
                    return
                }
                
                guard let user = authResult?.user else { return }
                
                let db = Firestore.firestore()
                db.collection("users").document(user.uid).setData([
                    "name": nameText,
                    "email": emailText
                ]) { error in
                    if let error = error {
                        print("Error saving user data: \(error.localizedDescription)")
                    }
                }
                DispatchQueue.main.async {
                    let viewController = ViewController()
                    guard let window = self.view.window else { return }
                    window.rootViewController = viewController
                }
            }
        }
    }
    
    @objc func handleLogin() {
        navigationController?.popViewController(animated: true)
    }
}

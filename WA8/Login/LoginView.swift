//
//  LoginView.swift
//  WA8
//
//  Created by Sai Vihar Reddy Gunamgari on 11/2/25.
//

import UIKit

class LoginView: UIView {
    var contentWrapper: UIScrollView!
    var emailLabel: UILabel!
    var emailTextField: UITextField!
    var passwordLabel: UILabel!
    var passwordTextField: UITextField!
    var errorLabel: UITextView!
    var loginButton: UIButton!
    var signupLabel: UILabel!
    var signupButton: UIButton!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        setupContentWrapper()
        setupEmailLabel()
        setupEmailTextField()
        setupPasswordLabel()
        setupPasswordTextField()
        setupErrorLabel()
        setupLoginButton()
        setupSignupLabel()
        setupSignupButton()
        
        initConstraints()
    }
    
    func setupContentWrapper() {
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentWrapper)
    }
    
    func setupEmailLabel() {
        emailLabel = UILabel()
        emailLabel.text = "Email"
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(emailLabel)
    }
    
    func setupEmailTextField() {
        emailTextField = UITextField()
        emailTextField.borderStyle = .roundedRect
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(emailTextField)
    }
    
    func setupPasswordLabel() {
        passwordLabel = UILabel()
        passwordLabel.text = "Password"
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(passwordLabel)
    }
    
    func setupPasswordTextField() {
        passwordTextField = UITextField()
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        var config = UIButton.Configuration.plain()
        let iconConfig = UIImage.SymbolConfiguration(pointSize: 11, weight: .regular)
        config.image = UIImage(systemName: "eye.fill", withConfiguration: iconConfig)
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 8)
        config.baseForegroundColor = .secondaryLabel
        let toggleBtn = UIButton(configuration: config)
        toggleBtn.addTarget(self, action: #selector(togglePwdVisibility), for: .touchUpInside)
        
        passwordTextField.rightView = toggleBtn
        passwordTextField.rightViewMode = .always
        contentWrapper.addSubview(passwordTextField)
    }
    
    func setupErrorLabel() {
        errorLabel = UITextView()
        errorLabel.backgroundColor = .systemBackground
        errorLabel.textColor = .red
        errorLabel.isHidden = true
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(errorLabel)
    }
    
    func setupLoginButton() {
        loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(loginButton)
    }
    
    func setupSignupLabel() {
        signupLabel = UILabel()
        signupLabel.text = "Don't have an account?"
        signupLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(signupLabel)
    }
    
    func setupSignupButton() {
        signupButton = UIButton(type: .system)
        signupButton.setTitle("Signup", for: .normal)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(signupButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            contentWrapper.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            contentWrapper.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: contentWrapper.contentLayoutGuide.topAnchor, constant: 32),
            emailLabel.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            emailTextField.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.widthAnchor, multiplier: 0.6),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordLabel.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.widthAnchor, multiplier: 0.6),
            
            errorLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            errorLabel.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 32),
            errorLabel.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -32),
            errorLabel.heightAnchor.constraint(equalToConstant: 24),
            
            loginButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 24),
            loginButton.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 100),
            
            signupLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            signupLabel.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            
            signupButton.topAnchor.constraint(equalTo: signupLabel.bottomAnchor, constant: 8),
            signupButton.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            signupButton.widthAnchor.constraint(equalToConstant: 100),
            signupButton.bottomAnchor.constraint(equalTo: contentWrapper.contentLayoutGuide.bottomAnchor, constant: -32)
        ])
    }
    
    @objc func togglePwdVisibility(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        
        var config = sender.configuration
        let iconConfig = UIImage.SymbolConfiguration(pointSize: 11, weight: .regular)
        let img = UIImage(
            systemName: passwordTextField.isSecureTextEntry ? "eye.fill" : "eye.slash.fill",
            withConfiguration: iconConfig
        )
        config?.image = img
        config?.baseForegroundColor = .secondaryLabel
        sender.configuration = config
        
        if let existingText = passwordTextField.text {
            passwordTextField.text = ""
            passwordTextField.text = existingText
        }
    }
    
}

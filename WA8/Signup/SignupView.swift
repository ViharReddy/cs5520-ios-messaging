//
//  SignupView.swift
//  WA8
//
//  Created by Sai Vihar Reddy Gunamgari on 11/2/25.
//

import UIKit

class SignupView: UIView {
    var contentWrapper: UIScrollView!
    var nameLabel: UILabel!
    var nameTextField: UITextField!
    var emailLabel: UILabel!
    var emailTextField: UITextField!
    var passwordLabel: UILabel!
    var passwordTextField: UITextField!
    var confirmPasswordLabel: UILabel!
    var confirmPasswordTextField: UITextField!
    var errorLabel: UITextView!
    var signupButton: UIButton!
    var loginLabel: UILabel!
    var loginButton: UIButton!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        setupContentWrapper()
        setupNameLabel()
        setupNameTextField()
        setupEmailLabel()
        setupEmailTextField()
        setupPasswordLabel()
        setupPasswordTextField()
        setupConfirmPasswordLabel()
        setupConfirmPasswordTextField()
        setupErrorLabel()
        setupSignupButton()
        setupLoginLabel()
        setupLoginButton()
        
        initConstraints()
    }
    
    func setupContentWrapper() {
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentWrapper)
    }
    
    func setupNameLabel() {
        nameLabel = UILabel()
        nameLabel.text = "Name"
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(nameLabel)
    }
    
    func setupNameTextField() {
        nameTextField = UITextField()
        nameTextField.borderStyle = .roundedRect
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(nameTextField)
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
        
        var config = UIButton.Configuration.plain()
        let iconConfig = UIImage.SymbolConfiguration(pointSize: 11, weight: .regular)
        config.image = UIImage(systemName: "eye.fill", withConfiguration: iconConfig)
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 8)
        config.baseForegroundColor = .secondaryLabel
        let toggleBtn = UIButton(configuration: config)
        toggleBtn.tag = 1
        toggleBtn.addTarget(self, action: #selector(togglePwdVisibility), for: .touchUpInside)
        
        passwordTextField.rightView = toggleBtn
        passwordTextField.rightViewMode = .always
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(passwordTextField)
    }
    
    func setupConfirmPasswordLabel() {
        confirmPasswordLabel = UILabel()
        confirmPasswordLabel.text = "Confirm Password"
        confirmPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(confirmPasswordLabel)
    }
    
    func setupConfirmPasswordTextField() {
        confirmPasswordTextField = UITextField()
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.borderStyle = .roundedRect
        
        var config = UIButton.Configuration.plain()
        let iconConfig = UIImage.SymbolConfiguration(pointSize: 11, weight: .regular)
        config.image = UIImage(systemName: "eye.fill", withConfiguration: iconConfig)
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 8)
        config.baseForegroundColor = .secondaryLabel
        let toggleBtn = UIButton(configuration: config)
        toggleBtn.tag = 2
        toggleBtn.addTarget(self, action: #selector(togglePwdVisibility), for: .touchUpInside)
        
        confirmPasswordTextField.rightView = toggleBtn
        confirmPasswordTextField.rightViewMode = .always
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(confirmPasswordTextField)
    }
    
    func setupErrorLabel() {
        errorLabel = UITextView()
        errorLabel.isEditable = false
        errorLabel.isScrollEnabled = false
        errorLabel.textAlignment = .center
        errorLabel.textColor = .red
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(errorLabel)
    }
    
    func setupSignupButton() {
        signupButton = UIButton(type: .system)
        signupButton.setTitle("Signup", for: .normal)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(signupButton)
    }
    
    func setupLoginLabel() {
        loginLabel = UILabel()
        loginLabel.text = "Already have an account?"
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(loginLabel)
    }
    
    func setupLoginButton() {
        loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(loginButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            contentWrapper.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            contentWrapper.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: contentWrapper.contentLayoutGuide.topAnchor, constant: 32),
            nameLabel.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            nameTextField.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.widthAnchor, multiplier: 0.6),
            
            emailLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            emailLabel.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 16),
            emailTextField.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.widthAnchor, multiplier: 0.6),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordLabel.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 16),
            passwordTextField.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.widthAnchor, multiplier: 0.6),
            
            confirmPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            confirmPasswordLabel.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor, constant: 16),
            confirmPasswordTextField.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            confirmPasswordTextField.widthAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.widthAnchor, multiplier: 0.6),
            
            errorLabel.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 16),
            errorLabel.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 32),
            errorLabel.trailingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -32),
            
            signupButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor),
            signupButton.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            signupButton.widthAnchor.constraint(equalToConstant: 100),
            
            loginLabel.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 16),
            loginLabel.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            
            loginButton.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 8),
            loginButton.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 100),
            loginButton.bottomAnchor.constraint(equalTo: contentWrapper.contentLayoutGuide.bottomAnchor, constant: -32)
        ])
    }
    
    @objc func togglePwdVisibility(_ sender: UIButton) {
        let textField = sender.tag == 1 ? passwordTextField : confirmPasswordTextField
        textField?.isSecureTextEntry.toggle()
        
        var config = sender.configuration
        let iconConfig = UIImage.SymbolConfiguration(pointSize: 11, weight: .regular)
        let img = UIImage(
            systemName: (textField?.isSecureTextEntry ?? true) ? "eye.fill" : "eye.slash.fill",
            withConfiguration: iconConfig
        )
        config?.image = img
        config?.baseForegroundColor = .secondaryLabel
        sender.configuration = config
        
        if let existingText = textField?.text {
            textField?.text = ""
            textField?.text = existingText
        }
    }
}

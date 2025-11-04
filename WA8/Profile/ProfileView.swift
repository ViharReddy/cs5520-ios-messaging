//
//  ProfileView.swift
//  WA8
//
//  Created by Sai Vihar Reddy Gunamgari on 11/2/25.
//

import UIKit

class ProfileView: UIView {
    var contentWrapper: UIScrollView!
    var nameLabel: UILabel!
    var nameValueLabel: UILabel!
    var emailLabel: UILabel!
    var emailValueLabel: UILabel!
    var signoutButton: UIButton!
    var loadingSpinner: UIActivityIndicatorView!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        setupContentWrapper()
        setupNameLabel()
        setupNameValueLabel()
        setupEmailLabel()
        setupEmailValueLabel()
        setupSignoutButton()
        setupLoadingSpinner()
        
        initConstraints()
    }
    
    func setupContentWrapper() {
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentWrapper)
    }
    
    func setupNameLabel() {
        nameLabel = UILabel()
        nameLabel.text = "Name:"
        nameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(nameLabel)
    }
    
    func setupNameValueLabel() {
        nameValueLabel = UILabel()
        nameValueLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(nameValueLabel)
    }
    
    func setupEmailLabel() {
        emailLabel = UILabel()
        emailLabel.text = "Email:"
        emailLabel.font = .systemFont(ofSize: 17, weight: .bold)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(emailLabel)
    }
    
    func setupEmailValueLabel() {
        emailValueLabel = UILabel()
        emailValueLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(emailValueLabel)
    }
    
    func setupSignoutButton() {
        signoutButton = UIButton(type: .system)
        signoutButton.setTitle("Sign Out", for: .normal)
        signoutButton.tintColor = .systemRed
        signoutButton.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(signoutButton)
    }
    
    func setupLoadingSpinner() {
        loadingSpinner = UIActivityIndicatorView(style: .large)
        loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loadingSpinner)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            contentWrapper.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            contentWrapper.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: contentWrapper.contentLayoutGuide.topAnchor, constant: 32),
            nameLabel.leadingAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.leadingAnchor, constant: 32),
            nameLabel.widthAnchor.constraint(equalToConstant: 64),
            
            nameValueLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            nameValueLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4),
            nameValueLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentWrapper.frameLayoutGuide.trailingAnchor, constant: -32),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            emailLabel.widthAnchor.constraint(equalToConstant: 64),
            
            emailValueLabel.topAnchor.constraint(equalTo: emailLabel.topAnchor),
            emailValueLabel.leadingAnchor.constraint(equalTo: nameValueLabel.leadingAnchor),
            
            signoutButton.topAnchor.constraint(equalTo: emailValueLabel.bottomAnchor, constant: 32),
            signoutButton.centerXAnchor.constraint(equalTo: contentWrapper.frameLayoutGuide.centerXAnchor),
            signoutButton.bottomAnchor.constraint(equalTo: contentWrapper.contentLayoutGuide.bottomAnchor, constant: -32),
            
            loadingSpinner.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            loadingSpinner.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    func startLoading() {
        loadingSpinner.startAnimating()
        contentWrapper.isHidden = true
    }
    
    func stopLoading() {
        loadingSpinner.stopAnimating()
        contentWrapper.isHidden = false
    }

}

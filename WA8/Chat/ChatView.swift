//
//  ChatView.swift
//  WA8
//
//  Created by Sai Vihar Reddy Gunamgari on 11/3/25.
//

import UIKit

class ChatView: UIView {
    var messagesTableView: UITableView!
    var sendMsgView: UIView!
    var sendMsgTextField: UITextField!
    var sendMsgButton: UIButton!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGray6
        
        setupMessagesTableView()
        setupSendMsgView()
        setupSendMsgTextField()
        setupSendMsgButton()
        
        initConstraints()
    }
    
    func setupMessagesTableView() {
        messagesTableView = UITableView()
        messagesTableView.register(OutgoingMsgCell.self, forCellReuseIdentifier: "outgoingMsgs")
        messagesTableView.register(IncomingMsgCell.self, forCellReuseIdentifier: "incomingMsgs")
        messagesTableView.separatorStyle = .none
        messagesTableView.allowsSelection = false
        messagesTableView.keyboardDismissMode = .interactive
        messagesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(messagesTableView)
    }
    
    func setupSendMsgView() {
        sendMsgView = UIView()
        sendMsgView.backgroundColor = .systemGray6
        sendMsgView.layer.cornerRadius = 8
        sendMsgView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sendMsgView)
    }
    
    func setupSendMsgTextField() {
        sendMsgTextField = UITextField()
        sendMsgTextField.placeholder = "Type your message..."
        sendMsgTextField.borderStyle = .roundedRect
        sendMsgTextField.translatesAutoresizingMaskIntoConstraints = false
        
        sendMsgView.addSubview(sendMsgTextField)
    }
    
    func setupSendMsgButton() {
        sendMsgButton = UIButton(type: .system)
        sendMsgButton.setTitle("Send", for: .normal)
        sendMsgButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        sendMsgButton.translatesAutoresizingMaskIntoConstraints = false
        
        sendMsgView.addSubview(sendMsgButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            sendMsgView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            sendMsgView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            sendMsgView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            sendMsgView.heightAnchor.constraint(equalToConstant: 50),
            
            messagesTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            messagesTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            messagesTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            messagesTableView.bottomAnchor.constraint(equalTo: sendMsgView.topAnchor),
            
            sendMsgTextField.leadingAnchor.constraint(equalTo: sendMsgView.leadingAnchor, constant: 8),
            sendMsgTextField.centerYAnchor.constraint(equalTo: sendMsgView.centerYAnchor),
            sendMsgTextField.heightAnchor.constraint(equalToConstant: 36),
            
            sendMsgButton.leadingAnchor.constraint(equalTo: sendMsgTextField.trailingAnchor, constant: 8),
            sendMsgButton.trailingAnchor.constraint(equalTo: sendMsgView.trailingAnchor, constant: -8),
            sendMsgButton.centerYAnchor.constraint(equalTo: sendMsgView.centerYAnchor),
            sendMsgButton.widthAnchor.constraint(equalToConstant: 50),
            
            sendMsgTextField.trailingAnchor.constraint(equalTo: sendMsgButton.leadingAnchor, constant: -8)
        ])
    }

}

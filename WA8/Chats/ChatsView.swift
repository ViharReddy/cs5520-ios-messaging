//
//  ChatsView.swift
//  WA8
//
//  Created by Sai Vihar Reddy Gunamgari on 11/2/25.
//

import UIKit

class ChatsView: UIView {
    var chatsTableView: UITableView!
    var noChatsLabel: UILabel!

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        setupChatsTableView()
        setupNoChatsLabel()
        
        initConstraints()
    }
    
    func setupChatsTableView() {
        chatsTableView = UITableView()
        chatsTableView.register(ChatsTableViewCell.self, forCellReuseIdentifier: "chats")
        chatsTableView.separatorStyle = .none
        chatsTableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(chatsTableView)
    }
    
    func setupNoChatsLabel() {
        noChatsLabel = UILabel()
        noChatsLabel.text = "No chats yet. Tap + to create a new chat!"
        noChatsLabel.isHidden = true
        noChatsLabel.font = .systemFont(ofSize: 17, weight: .medium)
        noChatsLabel.textColor = .secondaryLabel
        noChatsLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(noChatsLabel)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            chatsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            chatsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            chatsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            chatsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -32),
            
            noChatsLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            noChatsLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
}

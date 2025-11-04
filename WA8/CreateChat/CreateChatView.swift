//
//  CreateChatView.swift
//  WA8
//
//  Created by Sai Vihar Reddy Gunamgari on 11/3/25.
//

import UIKit

class CreateChatView: UIView {
    var usersTableView: UITableView!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        setupUsersTableView()
        
        initConstraints()
    }
    
    func setupUsersTableView() {
        usersTableView = UITableView()
        usersTableView.register(UsersTableViewCell.self, forCellReuseIdentifier: "users")
        usersTableView.allowsMultipleSelection = true
        usersTableView.tableFooterView = UIView()
        usersTableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(usersTableView)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            usersTableView.topAnchor.constraint(equalTo: topAnchor),
            usersTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            usersTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            usersTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

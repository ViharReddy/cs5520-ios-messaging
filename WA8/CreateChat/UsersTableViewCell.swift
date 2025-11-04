//
//  UsersTableViewCell.swift
//  WA8
//
//  Created by Sai Vihar Reddy Gunamgari on 11/3/25.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
    var wrapperCellView: UIView!
    var nameLabel: UILabel!
    var emailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupNameLabel()
        setupEmailLabel()
        
        initConstraints()
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UIView()
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(wrapperCellView)
    }
    
    func setupNameLabel() {
        nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        nameLabel.textColor = .label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(nameLabel)
    }
    
    func setupEmailLabel() {
        emailLabel = UILabel()
        emailLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        emailLabel.textColor = .secondaryLabel
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(emailLabel)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: topAnchor),
            wrapperCellView.leadingAnchor.constraint(equalTo: leadingAnchor),
            wrapperCellView.trailingAnchor.constraint(equalTo: trailingAnchor),
            wrapperCellView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            emailLabel.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -8)
        ])
    }
    
}

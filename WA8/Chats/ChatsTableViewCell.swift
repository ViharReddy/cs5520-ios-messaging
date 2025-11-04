//
//  ChatsTableViewCell.swift
//  WA8
//
//  Created by Sai Vihar Reddy Gunamgari on 11/2/25.
//

import UIKit

class ChatsTableViewCell: UITableViewCell {
    var wrapperCellView: UIView!
    var stackView: UIStackView!
    var nameLabel: UILabel!
    var timeLabel: UILabel!
    var msgLabel: UILabel!

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
        setupHorizontalStack()
        setupNameLabel()
        setupTimeLabel()
        setupMsgLabel()
        
        initConstraints()
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UIView()
        wrapperCellView.backgroundColor = .systemGray6
        wrapperCellView.layer.cornerRadius = 8
        wrapperCellView.layer.shadowColor = UIColor.black.cgColor
        wrapperCellView.layer.shadowOffset = CGSize(width: 0, height: 2)
        wrapperCellView.layer.shadowOpacity = 0.2
        wrapperCellView.layer.shadowRadius = 4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(wrapperCellView)
    }
    
    func setupHorizontalStack() {
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        wrapperCellView.addSubview(stackView)
    }
    
    func setupNameLabel() {
        nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nameLabel.textColor = .label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(nameLabel)
    }
    
    func setupTimeLabel() {
        timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        timeLabel.textColor = .secondaryLabel
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(timeLabel)
    }
    
    func setupMsgLabel() {
        msgLabel = UILabel()
        msgLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        msgLabel.textColor = .label
        msgLabel.numberOfLines = 2
        msgLabel.lineBreakMode = .byTruncatingTail
        msgLabel.translatesAutoresizingMaskIntoConstraints = false
        
        wrapperCellView.addSubview(msgLabel)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            wrapperCellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            wrapperCellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            wrapperCellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            stackView.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -8),
            
            msgLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 4),
            msgLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 8),
            msgLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -8),
            msgLabel.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -8)
        ])
    }
    
}

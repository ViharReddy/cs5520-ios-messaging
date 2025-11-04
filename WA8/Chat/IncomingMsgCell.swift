//
//  IncomingMsgCell.swift
//  WA8
//
//  Created by Sai Vihar Reddy Gunamgari on 11/3/25.
//

import UIKit

class IncomingMsgCell: UITableViewCell {
    var bubbleView: UIView!
    var stackView: UIStackView!
    var messageLabel: UILabel!
    var timeLabel: UILabel!
    
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
        
        selectionStyle = .none
        
        setupBubbleView()
        setupStackView()
        setupMessageLabel()
        setupTimeLabel()
        
        initConstraints()
    }
    
    func setupBubbleView() {
        bubbleView = UIView()
        bubbleView.backgroundColor = .systemGray5
        bubbleView.layer.cornerRadius = 16
        bubbleView.layer.masksToBounds = true
        bubbleView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bubbleView)
    }
    
    func setupStackView() {
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bubbleView.addSubview(stackView)
    }
    
    func setupMessageLabel() {
        messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .black
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(messageLabel)
    }
    
    func setupTimeLabel() {
        timeLabel = UILabel()
        timeLabel.font = .systemFont(ofSize: 11, weight: .light)
        timeLabel.textColor = .darkGray
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(timeLabel)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            bubbleView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            bubbleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            bubbleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            bubbleView.trailingAnchor.constraint(lessThanOrEqualTo: centerXAnchor),
            bubbleView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.7),
            
            stackView.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -8)
        ])
    }
    
}

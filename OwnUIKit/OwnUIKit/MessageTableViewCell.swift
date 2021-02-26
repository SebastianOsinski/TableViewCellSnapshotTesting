//
//  MessageTableViewCell.swift
//  CellSnapshotTesting
//
//  Created by Sebastian Osiński on 02/09/2019.
//  Copyright © 2019 Sebastian Osiński. All rights reserved.
//

import UIKit

public class MessageTableViewCell: UITableViewCell {
    public let avatar = UIView()
    public let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        label.numberOfLines = 0
        
        contentView.addSubview(avatar)
        contentView.addSubview(label)
        
        avatar.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            avatar.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor),
            avatar.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            avatar.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15),
            avatar.heightAnchor.constraint(greaterThanOrEqualTo: avatar.widthAnchor),
            label.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            label.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 20.0),
            label.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }
}

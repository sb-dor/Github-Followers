//
//  FollowerCell.swift
//  testapp
//
//  Created by Avaz on 24/09/24.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseId = "FollowerCell"
    let avatartImageView = GFAvatarImageView(frame: .zero)
    let userNameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    let padding : CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAvatartImageVoew()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower?) {
        userNameLabel.text = follower?.login
    }
    
    private func configureAvatartImageVoew() {
        addSubview(avatartImageView)
        addSubview(userNameLabel)
    
        NSLayoutConstraint.activate([
            avatartImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatartImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatartImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatartImageView.heightAnchor.constraint(equalToConstant: 100),
            avatartImageView.widthAnchor.constraint(equalToConstant: 100),
            
            userNameLabel.topAnchor.constraint(equalTo: avatartImageView.bottomAnchor, constant: 10),
            userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            userNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}

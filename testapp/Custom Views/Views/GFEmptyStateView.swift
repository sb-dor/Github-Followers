//
//  GFEmptyStateView.swift
//  testapp
//
//  Created by Avaz on 01/10/24.
//

import UIKit

class GFEmptyStateView: UIView {
    
    var titleLabel: GFTitleLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        configure()
    }
    
    private func configure() {
        addSubview(titleLabel)
        addSubview(logoImageView)
        
        titleLabel.numberOfLines = 3
        titleLabel.textColor = .secondaryLabel
        
        logoImageView.image = UIImage(named: "empty-state-logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            titleLabel.heightAnchor.constraint(equalToConstant: 200),
            
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 200),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40),
        ])
    }
    
}

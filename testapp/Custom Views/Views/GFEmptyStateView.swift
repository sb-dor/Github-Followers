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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(titleLabel)
        addSubview(logoImageView)
        
        titleLabel.numberOfLines = 3
        titleLabel.textColor = .secondaryLabel
        
        logoImageView.image = UIImage(named: "empty-state-logo")
    }
    
}

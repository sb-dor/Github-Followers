//
//  GFSecondaryTitleLabel.swift
//  testapp
//
//  Created by Avaz on 06/10/24.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame);
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        
        configure()
    }

    private func configure() {
        textColor                   = .secondaryLabel
        textAlignment            = .left
        // if the text if too long it will small that
        adjustsFontSizeToFitWidth      = true
        minimumScaleFactor            = 0.75
        // it look like the text ellipses in flutter
        lineBreakMode                = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}

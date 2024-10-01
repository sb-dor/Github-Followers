//
//  GFTitleLabel.swift
//  testapp
//
//  Created by Avaz on 22/09/24.
//

import UIKit

class GFTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }

    private func configure() {
        textColor = .label
        // if the text if too long it will small that
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        // it look like the text ellipses in flutter
        lineBreakMode = .byTruncatingTail
        numberOfLines = 1
        translatesAutoresizingMaskIntoConstraints = false
    }
}

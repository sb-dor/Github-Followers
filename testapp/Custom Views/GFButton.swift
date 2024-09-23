//
//  GFButton.swift
//  testapp
//
//  Created by Avaz on 22/09/24.
//

import UIKit

class GFButton: UIButton {

    // this is necessary
    override init(frame: CGRect) {
        super.init(frame: frame)
        // code
        configure()
    }
    
    // this is not ecessary
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // custom init constructor
    init(background: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = background
        self.setTitle(title, for: .normal) // for is several type of button like, selected, normal
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

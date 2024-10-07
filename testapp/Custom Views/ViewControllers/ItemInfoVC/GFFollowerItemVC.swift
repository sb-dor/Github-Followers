//
//  GFFollowerItemVC.swift
//  testapp
//
//  Created by Avaz on 07/10/24.
//

import UIKit

class GfFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoOne.set(itemInfoType: .followers, count: user.followers)
        iteminfoTwo.set(itemInfoType: .following, count: user.following)
        actionButton.set(background: .systemGreen, title: "Get Followers")
        
    }
    
}


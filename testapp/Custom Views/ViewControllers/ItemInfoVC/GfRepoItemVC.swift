//
//  GfRepoItemVC.swift
//  testapp
//
//  Created by Avaz on 07/10/24.
//

import UIKit

class GfRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoOne.set(itemInfoType: .repos, count: user.publicRepos)
        iteminfoTwo.set(itemInfoType: .gists, count: user.publicGists)
        actionButton.set(background: .systemPurple, title: "Github Profile")
        
    }
    
}

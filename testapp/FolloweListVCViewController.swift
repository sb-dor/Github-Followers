//
//  FolloweListVCViewController.swift
//  testapp
//
//  Created by Avaz on 22/09/24.
//

import UIKit

class FolloweListVCViewController: UIViewController {
    
    var userName : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

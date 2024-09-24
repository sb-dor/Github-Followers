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
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: userName, page: 1) { result in
            
            
            switch(result) {
            case .success(let followers):
                print("Followers count = \(( followers ?? [] ).count)")
                print(followers ?? [])
            case .failure(let errorMessage) :
                self.presentGFAlertOnMainThread(title: "Test message", message: errorMessage.rawValue, buttonTitle: "Ok")
            }
            
            
            //            guard let followers = followers else {
            //
            //                return
            //            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

//
//  UserInfoVC.swift
//  testapp
//
//  Created by Avaz on 04/10/24.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var userName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = userName ?? "-"
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissPopup))
        navigationItem.rightBarButtonItem = doneButton
        
        NetworkManager.shared.getUserInfo(userName: userName) { [weak self] result in
            
            guard let self = self else { return }
            
            switch(result) {
                case .failure(let error) :
                self.presentGFAlertOnMainThread(title: "Test message", message: error.rawValue, buttonTitle: "Ok")
                break;
            case .success(let user):
                print("user name is: \(user)")
            }
        }
    }
    
    
    @objc private func dismissPopup() {
        dismiss(animated: true)
    }
    
}

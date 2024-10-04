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
    }
   
    
    @objc private func dismissPopup() {
        dismiss(animated: true)
    }
    
}

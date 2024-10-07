//
//  UserInfoVC.swift
//  testapp
//
//  Created by Avaz on 04/10/24.
//

import UIKit

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    
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
                DispatchQueue.main.async{
                    self.add(childVC: GFUserInfoHeaderVC(user: user), continerView: self.headerView)
                }
//                print("user name is: \(user)")
            }
        }
        
        callUILayout()
    }
    
    
    @objc private func dismissPopup() {
        dismiss(animated: true)
    }
    
    private func callUILayout() {
        view.addSubview(headerView)
        view.addSubview(itemViewOne)
        view.addSubview(itemViewTwo)
        
        itemViewOne.backgroundColor = .systemPink
        itemViewTwo.backgroundColor = .systemBlue

        headerView.translatesAutoresizingMaskIntoConstraints = false
        itemViewOne.translatesAutoresizingMaskIntoConstraints = false
        itemViewTwo.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewOne.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
        ])
    }
    
    private func add(childVC: UIViewController, continerView: UIView) {
        addChild(childVC)
        continerView.addSubview(childVC.view)
        childVC.view.frame = view.bounds
        childVC.didMove(toParent: self)
    }
    
}

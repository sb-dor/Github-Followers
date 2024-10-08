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
    var itemViews : [UIView] = []
    
    var userName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        callUILayout()
        getUserInfo()
    }
    
    
    @objc private func dismissPopup() {
        dismiss(animated: true)
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = userName ?? "-"
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissPopup))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func callUILayout() {
        itemViews = [headerView, itemViewOne, itemViewTwo]
        
        for each in itemViews {
            view.addSubview(each)
            each.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // this code was written inside for loop
        //        view.addSubview(headerView)
        //        view.addSubview(itemViewOne)
        //        view.addSubview(itemViewTwo)
        
//        itemViewOne.backgroundColor = .systemPink
//        itemViewTwo.backgroundColor = .systemBlue
        
        // this code was written inside for loop
        //        headerView.translatesAutoresizingMaskIntoConstraints = false
        //        itemViewOne.translatesAutoresizingMaskIntoConstraints = false
        //        itemViewTwo.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            //
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
        ])
    }
    
    private func add(childVC: UIViewController, continerView: UIView) {
        addChild(childVC)
        continerView.addSubview(childVC.view)
        
        childVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            childVC.view.topAnchor.constraint(equalTo: continerView.topAnchor),
            childVC.view.leadingAnchor.constraint(equalTo: continerView.leadingAnchor),
            childVC.view.trailingAnchor.constraint(equalTo: continerView.trailingAnchor),
            childVC.view.bottomAnchor.constraint(equalTo: continerView.bottomAnchor)
        ])
        
        childVC.didMove(toParent: self)
    }
    
    private func getUserInfo() {
        NetworkManager.shared.getUserInfo(userName: userName) { [weak self] result in
            
            guard let self = self else { return }
            
            switch(result) {
            case .failure(let error) :
                self.presentGFAlertOnMainThread(title: "Test message", message: error.rawValue, buttonTitle: "Ok")
                break;
            case .success(let user):
                DispatchQueue.main.async{
                    self.add(childVC: GFUserInfoHeaderVC(user: user), continerView: self.headerView)
                    self.add(childVC: GfRepoItemVC(user: user), continerView: self.itemViewOne)
                    self.add(childVC: GfFollowerItemVC(user: user), continerView: self.itemViewTwo)
                }
                //                print("user name is: \(user)")
            }
        }
    }
    
}

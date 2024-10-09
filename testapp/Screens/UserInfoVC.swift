//
//  UserInfoVC.swift
//  testapp
//
//  Created by Avaz on 04/10/24.
//

import UIKit
import SafariServices

protocol UserInfoVCDelegate: AnyObject {
    func didTapGithubProfile(user: User?)
    func didTapGetFollowers(user: User?)
}

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    var itemViews : [UIView] = []
    
    var userName: String?
    
    weak var followersListVCDelegate: FolloweListVCDelegate!
    
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
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
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
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func add(childVC: UIViewController, continerView: UIView) {
        addChild(childVC)
        continerView.addSubview(childVC.view)
        childVC.view.frame = continerView.bounds
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
                    let repoItem = GfRepoItemVC(user: user)
                    let followerItem = GfFollowerItemVC(user: user)
                    repoItem.delegate = self
                    followerItem.delegate = self
                    
                    
                    
                    self.add(childVC: repoItem, continerView: self.itemViewOne)
                    self.add(childVC: followerItem, continerView: self.itemViewTwo)
                    self.dateLabel.text = "GitHub Since \(user?.createdAt?.convertToDisplayFormat() ?? "")"
                }
                //                print("user name is: \(user)")
            }
        }
    }
}

extension UserInfoVC: UserInfoVCDelegate {
    // function than opens Safari browser with specific URL
    func didTapGithubProfile(user: User?) {
        guard let url = URL(string: user?.htmlUrl ?? "") else {
            self.presentGFAlertOnMainThread(title: "Invalid url", message: "no url", buttonTitle: "Ok")
            return;
        }
        
        openSafariByURL(url: url)
        
    }
    
    func didTapGetFollowers(user: User?) {
        followersListVCDelegate.didRequestFollowers(userName: user?.login)
        dismissPopup()
    }
    
    
}

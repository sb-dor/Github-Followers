//
//  FolloweListVCViewController.swift
//  testapp
//
//  Created by Avaz on 22/09/24.
//

import UIKit

class FolloweListVCViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    var userName : String?
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var followers : [Follower] = []
    
    // collection view is similar to Flutter's ListView or GridView
    var collectionView : UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewContoller()
        configureCollectionView()
        getFollowers()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureViewContoller() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    
    private func createThreeColumnLayout() -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width;
        let padding: CGFloat            = 12;
        let minimumItemSpacing: CGFloat = 10;
        let availableWidth          = width - (padding * 2) - (minimumItemSpacing * 2);
        let itemWidth               = availableWidth / 3;
        
        let flowLayout = UICollectionViewFlowLayout();
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: {(collectionView, indexPath, follower) -> UICollectionViewCell? in
            
            let cellView = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath)
            as! FollowerCell
            
            cellView.set(follower: follower)
            
            return cellView
        })
    }
    
    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        
        // an enum Section from above
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func getFollowers() {
        NetworkManager.shared.getFollowers(for: userName, page: 1) { result in
            switch(result) {
            case .success(let followers):
                print("Followers count = \(( followers ?? [] ).count)")
                print(followers ?? [])
                self.followers = followers ?? []
                self.updateData()
            case .failure(let errorMessage) :
                self.presentGFAlertOnMainThread(title: "Test message", message: errorMessage.rawValue, buttonTitle: "Ok")
            }
            
            
            //            guard let followers = followers else {
            //
            //                return
            //            }
            
        }
    }
}

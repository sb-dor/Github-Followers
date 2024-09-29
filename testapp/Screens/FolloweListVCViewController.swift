//
//  FolloweListVCViewController.swift
//  testapp
//
//  Created by Avaz on 22/09/24.
//

import UIKit

class FolloweListVCViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellView = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath)
        as! FollowerCell
        
        cellView.set(follower: followers[indexPath.item])
        
        return cellView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let numberOfColumns: CGFloat = 3 // Number of columns in the grid
        let availableWidth = collectionView.frame.width - (padding * (numberOfColumns + 1))
        let itemWidth = availableWidth / numberOfColumns
        
        return CGSize(width: itemWidth, height: itemWidth + 40) // Square cells for the grid
    }
    
    
    enum Section {
        case main
    }
    
    let padding: CGFloat = 10
    var userName : String?
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var followers : [Follower] = []
    
    // collection view is similar to Flutter's ListView or GridView
    var collectionView : UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewContoller()
        configureCollectionView()
//        configureDataSource()
        getFollowers()
       
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
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: createThreeColumnLayout())
        collectionView.backgroundColor = .systemBackground
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
        view.addSubview(collectionView)
    }
    
    private func createThreeColumnLayout() -> UICollectionViewFlowLayout {
//        let width                       = view.bounds.width;
//        let padding: CGFloat            = 12;
//        let minimumItemSpacing: CGFloat = 10;
//        let availableWidth             = width - (padding * 2) - (minimumItemSpacing * 2);
//        let itemWidth                  = availableWidth / 3;
//        
        let flowLayout = UICollectionViewFlowLayout();
        flowLayout.minimumInteritemSpacing = 10 // Spacing between items in a row
        flowLayout.minimumLineSpacing = 10 // Spacing between rows
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
//        debugPrint("itemWidth is : \(itemWidth)")
//        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
//    private func configureDataSource() {
//        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: {(collectionView, indexPath, follower) -> UICollectionViewCell? in
//            
//
//        })
//    }
    
    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        
        // an enum Section from above
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
                self.collectionView.reloadData() // Reload the collection view data
            }
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

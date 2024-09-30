//
//  FolloweListVCViewController.swift
//  testapp
//
//  Created by Avaz on 22/09/24.
//

import UIKit

class FolloweListVCViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    enum Section { case main }
    
    let padding: CGFloat = 10
    var userName : String?
//    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var followers : [Follower] = []
    var page: Int = 1
    var hasMore: Bool = true
    
    // collection view is similar to Flutter's ListView or GridView
    var collectionView : UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewContoller()
        configureCollectionView()
        getFollowers(userName: userName, page: page)
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
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: UIHelper.createThreeColumnLayout(view: view, padding: padding))
        collectionView.backgroundColor = .systemBackground
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
        view.addSubview(collectionView)
    }
    
    
    private func updateData() {
        DispatchQueue.main.async { self.collectionView.reloadData() }
    }
    
    
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
    
    private func getFollowers(userName: String?, page: Int) {
        
        showLoadingView()
        
        NetworkManager.shared.getFollowers(for: userName, page: page) {[weak self] result in
            
            self?.dismissLoadingView()
            
            guard let self = self else { return }
            
            switch(result) {
            case .success(let followers):
                if (followers?.count ?? 0) < 100 { hasMore = false }
                print("Followers count = \(( followers ?? [] ).count)")
                print(followers ?? [])
                self.followers.append(contentsOf: followers ?? []) // .addAll() int Dart
                self.updateData()
            case .failure(let errorMessage) :
                self.presentGFAlertOnMainThread(title: "Test message", message: errorMessage.rawValue, buttonTitle: "Ok")
            }
        }
    }
}


extension FolloweListVCViewController: UICollectionViewDelegate {
    
    // pagination with scroll end
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offset = scrollView.contentOffset.y; // current offset
        let maxExtent = scrollView.contentSize.height; // entire scroll height
        let height = scrollView.frame.size.height; // screen height
        
        print("offset: \(offset)")
        print("maxExtent: \(maxExtent)")
        print("height: \(height)")
        
        // if the offset of screen is in the end
        if(offset > (maxExtent - height)) {
            guard hasMore else { return }
            page += 1;
            getFollowers(userName: userName, page: page)
        }
    }
    
    
    
}

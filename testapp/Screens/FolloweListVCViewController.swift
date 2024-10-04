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
    var filteredFollowers : [Follower] = []
    var page: Int = 1
    var hasMore: Bool = true
    
    // collection view is similar to Flutter's ListView or GridView
    var collectionView : UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
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
        return filteredFollowers.isEmpty ? followers.count : filteredFollowers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellView = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath)
        as! FollowerCell
        if(filteredFollowers.isEmpty){
            cellView.set(follower: followers[indexPath.item])
        }else{
            cellView.set(follower: filteredFollowers[indexPath.item])
        }
        return cellView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfColumns: CGFloat = 3 // Number of columns in the grid
        let availableWidth = collectionView.frame.width - (padding * (numberOfColumns + 1))
        let itemWidth = availableWidth / numberOfColumns
        return CGSize(width: itemWidth, height: itemWidth + 40) // Square cells for the grid
    }
    
    // onselect on item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follower: Follower?
        
        if(filteredFollowers.isEmpty){
            follower = followers[indexPath.item];
        }else{
            follower = filteredFollowers[indexPath.item]
        }
        
        let userInfoViewController = UserInfoVC()
        userInfoViewController.userName = follower?.login
        
        // this code will navigate to the view
//        navigationController?.pushViewController(userInfoViewController, animated: true)
        
        // this code will shoe like whole modal sheet
        // if we do like this it will appear only screen without buttons on top
//        present(userInfoViewController, animated: true)
        
        // but if we do like this, we can put actions similar to the flutter appbar
        // but buttons are written inside view controller
        let navigationModalControlelr = UINavigationController(rootViewController: userInfoViewController)
        present(navigationModalControlelr, animated: true)
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
                if (self.followers.isEmpty && (followers ?? []).isEmpty){
                    let titleForEmptyStateView = "This user does not have any followers";
                    DispatchQueue.main.async { self.showEmptyStateView(title: titleForEmptyStateView, view: self.view) }
                    return;
                }
                self.updateData()
            case .failure(let errorMessage) :
                self.presentGFAlertOnMainThread(title: "Test message", message: errorMessage.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a user name"
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
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

extension FolloweListVCViewController : UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        
        filteredFollowers = followers.filter({ follower in
            return (follower.login?.lowercased() ?? "").contains(filter.lowercased())
        })
        updateData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredFollowers.removeAll()
        updateData()
    }
    
}

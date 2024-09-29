//
//  TestGridViewController.swift
//  testapp
//
//  Created by Avaz on 29/09/24.
//

import UIKit

class TestGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    let numberOfItems = 100 // Example data count for grid items
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the layout for grid
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10 // Spacing between items in a row
        layout.minimumLineSpacing = 10 // Spacing between rows
        
        // Initialize the collection view with the layout
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        // Set data source and delegate
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Register the cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "gridCell")
        
        // Add the collection view to the view
        self.view.addSubview(collectionView)
    }
    
    // DataSource: Number of items in section (like itemCount in Flutter)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems // Total number of items in the grid
    }
    
    // DataSource: Create the cell for each item (like itemBuilder in Flutter)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridCell", for: indexPath)
        
        // Configure the cell
        cell.backgroundColor = .systemBlue
        
        // Add a label to show the index of the item
        let label = UILabel(frame: cell.bounds)
        label.text = "\(indexPath.row + 1)"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        
        // Remove any existing subviews (to avoid multiple labels)
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        // Add the label to the cell
        cell.contentView.addSubview(label)
        
        return cell
    }
    
    // DelegateFlowLayout: Define the size for each cell (grid layout)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let numberOfColumns: CGFloat = 3 // Number of columns in the grid
        let availableWidth = collectionView.frame.width - (padding * (numberOfColumns + 1))
        let itemWidth = availableWidth / numberOfColumns
        
        return CGSize(width: itemWidth, height: itemWidth) // Square cells for the grid
    }
}

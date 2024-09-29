//
//  TestListViewController.swift
//  testapp
//
//  Created by Avaz on 29/09/24.
//

import UIKit

class TestListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    let numberOfItems = 50 // Example data count for list items
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the table view
        tableView = UITableView(frame: self.view.frame)
        
        // Set the data source and delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        // Register a UITableViewCell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "listCell")
        
        // Add the table view to the view
        self.view.addSubview(tableView)
    }
    
    // DataSource: Number of rows (like itemCount in Flutter)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems // Total number of items in the list
    }
    
    // DataSource: Cell for each row (like itemBuilder in Flutter)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        
        // Customize the cell (like a ListTile in Flutter)
        cell.textLabel?.text = "Item \(indexPath.row + 1)"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
        
        return cell
    }
    
    // Delegate: Handle row selection (optional, like onTap in Flutter)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected item \(indexPath.row + 1)")
        tableView.deselectRow(at: indexPath, animated: true) // Deselect row after tap
    }
}

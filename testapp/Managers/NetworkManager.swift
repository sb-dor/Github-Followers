//
//  NetworkManager.swift
//  testapp
//
//  Created by Avaz on 23/09/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://api/github.com/users/"
    
    private init() {
        
    }
    
    func getFollowers(for userName: String, page: Int, completed: @escaping ([Follower]?, String?) -> Void) {
        let endpoint = baseUrl + "\(userName)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(nil, "Error occured")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data , response , error in
            
        }
        
        task.resume()
    }

}

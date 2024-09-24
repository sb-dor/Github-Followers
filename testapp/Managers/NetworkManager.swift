//
//  NetworkManager.swift
//  testapp
//
//  Created by Avaz on 23/09/24.
//

import Foundation


//  Class :
//
//   - Reference Type: Imagine a class like a shared document. When many people open the same document, they're all looking at the same thing. If someone makes changes, everyone sees those changes because they're looking at the same paper.

//   - Inheritance: Classes can have children, like a family tree. A child can inherit traits from their parents. For example, a "Car" class can have a child class like "SportsCar" that inherits features from the parent class.

//   - Mutable: You can change a class after you create it. It's like being able to erase and rewrite on a piece of paper.
//
//  Structs :
//
//   - Value Type: Think of a struct like a personal notebook. When you copy it, you get your own new notebook. If you make notes in your notebook, it doesn't affect someone else's notebook because they each have their own separate pages.
//   - No Inheritance: Structs can't have children or parents. Each struct is on its own; they can't inherit anything from other structs.
//   - Immutable: Once you create a struct, you can't change it. It's like having a notebook with pages that can't be erased or rewritten.

class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://api.github.com/users/"
    
    private init() {
        
    }
    
    // Function to retrieve a list of followers for a given GitHub username
    // Parameters:
    // - userName: The username whose followers you want to retrieve
    // - page: The page number for paginated followers list
    // - completed: A completion handler that returns either an array of Follower objects or an error message
    func getFollowers(for userName: String?, page: Int, completed: @escaping ([Follower]?, ErrorMessage?) -> Void) {
        
        // Constructing the API endpoint URL for fetching followers
        let endpoint = baseUrl + "\(userName ?? "")/followers?per_page=100&page=\(page)"
        
        // Attempting to convert the endpoint string into a URL object
        guard let url = URL(string: endpoint) else {
            // If URL conversion fails, call the completion handler with an error
            completed(nil, ErrorMessage.invalidUserName)
            return
        }
        
        // Creating a data task to fetch data from the constructed URL
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            // the _ is optional 
            // Check if an error occurred during the network request
            if let _ = error {
                // If an error exists, complete with an error message and return
                completed(nil, ErrorMessage.internetConnectionError)
            }
            
            // Verifying that the response is a valid HTTP response with status code 200 (success)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                // If status code is not 200, return an error
                completed(nil, .invalidResponse)
                return
            }
            
            // Ensuring that we received valid data from the server
            guard let data = data else {
                // If no data was received, complete with an error message
                completed(nil, .invalidData)
                return
            }
            
            do {
                // Attempt to decode the received data into an array of Follower objects
                let decoder = JSONDecoder()
                // Use convertFromSnakeCase strategy to map snake_case JSON keys to camelCase properties in Swift
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                // .self: This is used to refer to the type itself, not an instance of the type. In this case,
                // [Follower].self refers to the array type [Follower],
                // which is used when you need to pass the type as a parameter or use it in a generic context.
                let followers = try decoder.decode([Follower].self, from: data)
                // If successful, complete with the array of followers and no error
                completed(followers, nil)
            } catch {
                // If decoding fails, complete with an error message
//                completed(nil, "Error occurred while decoding data from server")
                completed(nil, .invalidData)
            }
        }
        
        // Start the data task
        task.resume()
    }
    
}

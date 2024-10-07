//
//  User.swift
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

struct User: Codable {
    let login: String?
    let avatarUrl: String?
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int?
    let publicGists: Int?
    let htmlUrl: String?
    let followers: Int?
    let following: Int?
    let createdAt: String?
}

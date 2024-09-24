//
//  Follower.swift
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




// Codable is the thing that when you write fields for it
// it should be exactly the same as json field
// it will match that and autmotaically set the value into field
// you done have to write like in Dart -> factory Follower.fromJson() and so on
// you can write fields in camelcase and Codable will convert that into snakeCase
struct Follower : Codable {
    var login: String?
    var avatarUrl : String?
    
    
}

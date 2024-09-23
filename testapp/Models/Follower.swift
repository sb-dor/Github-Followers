//
//  Follower.swift
//  testapp
//
//  Created by Avaz on 23/09/24.
//

import Foundation


// Codable is the thing that when you write fields for it
// it should be exactly the same as json field
// it will match that and autmotaically set the value into field
// you done have to write like in Dart -> factory Follower.fromJson() and so on
// you can write fields in camelcase and Codable will convert that into snakeCase
struct Follower : Codable {
    var login: String?
    var avatarUrl : String?
    
    
}

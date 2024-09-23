//
//  User.swift
//  testapp
//
//  Created by Avaz on 23/09/24.
//

import Foundation

struct User: Codable {
    var login: String?
    var avatarUrl: String?
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int?
    var publicGists: Int?
    var htmlUrl: String?
    var followers: Int?
    var createdAt: String?
}

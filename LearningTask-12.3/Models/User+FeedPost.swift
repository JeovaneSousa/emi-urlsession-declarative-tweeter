//
//  Author.swift
//  LearningTask-12.3
//
//  Created by rafael.rollo on 07/12/2022.
//

import Foundation

struct User: Codable {
    let id: Int?
    let fullName: String
    let username: String
    let profilePictureURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id, fullName, username
        case profilePictureURL = "profilePicturePath"
    }
}

class FeedPost: Codable {
    let author: User
    let createdAt: String
    let id: Int
    let imagePath: String?
    let reposting: FeedPost?
    let loves: Int
    let replies: Int
    let reposts: Int
    let textContent: String?
    
    var isReposting: Bool {
        return reposting != nil
    }
}

struct FeedPostInput: Codable {
    let imagePath: String?
    let textContent: String
    
    init(imagePath: String? = nil, textContent: String) {
        self.imagePath = imagePath
        self.textContent = textContent
    }
}



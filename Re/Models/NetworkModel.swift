//
//  NetworkModel.swift
//  Re
//
//  Created by 황인호 on 11/22/23.
//

import UIKit

struct EmailValidResult: Codable {
    let message: String
}

struct JoinValidResult: Codable {
    let email: String
    let password: String
    let nick: String
}

struct LoginValidResult: Codable {
    let _id: String
    let token: String
    let refreshToken: String
}

struct RefreshToken: Codable {
    let token: String
}

struct Posting: Decodable {
    let title, content: String
    let file: Data?
    let product_id: String
}

struct GetTest: Decodable {
    let data: [Datum]
    let nextCursor: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case nextCursor = "next_cursor"
    }
}

// MARK: - Datum
struct Datum: Codable {
    let likes, image: [String]
    let hashTags: [String]
    let comments: [Comment]
    let id: String
    let creator: Creator
    let time: String
    let title, content, content1, content2: String?
    let content3, content4, content5, productID: String?
    
    enum CodingKeys: String, CodingKey {
        case likes, image, hashTags, comments
        case id = "_id"
        case creator, time, title, content, content1, content2, content3, content4, content5
        case productID = "product_id"
    }
}

// MARK: - Comment
struct Comment: Codable {
    let id, content, time: String
    let creator: Creator
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case content, time, creator
    }
}

struct Creator: Codable {
    let id, nick: String
    let profile: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case nick, profile
    }
}

struct DetailInfo: Decodable {
    let id: String
    let like, image: [String]
    let comments: [Comment]
    let creator: Creator
    let time, title, content: String
}

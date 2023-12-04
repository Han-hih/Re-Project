//
//  NetworkModel.swift
//  Re
//
//  Created by 황인호 on 11/22/23.
//

import Foundation

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

struct Posting: Codable {
    let title, content: String
    let file: Data?
}

struct PostingGet: Codable {
    let likes: [String]
    let image: [String]
    let hashTags, comments: [String]
    let _id: String
    let time, title, content, productID: String
    let creator: Creator
}
struct Creator: Codable {
    let _id: String
    let nick: String
    let profile: String
}

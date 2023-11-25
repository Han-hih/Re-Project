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

//
//  NetworkError.swift
//  Re
//
//  Created by 황인호 on 11/24/23.
//

import Foundation

enum NetworkError: Int, Error {
    case valueEmpty = 400
    case invalidEmail = 409
    case expireToken = 418
    case decodingFailed = 999
    case unownedError = 1
}

enum LoginError: Int, Error {
    case unsignedValue = 401
}

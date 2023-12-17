//
//  NetworkError.swift
//  Re
//
//  Created by 황인호 on 11/24/23.
//

import Foundation

enum NetworkError: Int, Error {
    case valueEmpty = 400
    case invalidAccessToken = 401
    case invalidEmail = 409
    case noPosting = 410
    case expireToken = 418
    case expireAccess = 419
    case manyRequest = 429
    case notNormal = 444
    case decodingFailed = 999
    case unownedError = 500
        
    var errorMessage: String {
        switch self {
        case .valueEmpty:
            "필수값이 없음"
        case .invalidAccessToken:
            "유효하지 않은 액세스 토큰"
        case .invalidEmail:
            "유효하지 않은 이메일"
        case .expireToken:
            "토큰 만료"
        case .expireAccess:
            "액세스 토큰 만료"
        case .manyRequest:
            "과호출"
        case .notNormal:
            "비정상 접근"
        case .decodingFailed:
            "디코딩 실패"
        case .unownedError:
            "서버에러 일수도?"
        case .noPosting:
            "게시글 없음"
        }
    }
}

enum LoginError: Int, Error {
    case unsignedValue = 401
}

//
//  APIManager.swift
//  Re
//
//  Created by 황인호 on 11/21/23.
//

import Foundation
import Security
import Moya

enum APIManager {
    case emailValid(email: String)
    case join(email: String, password: String, nick: String)
    case login(email: String, password: String)
    case refresh(token: String, refreshToken: String)
}


extension APIManager: TargetType {
    
    
    
    var baseURL: URL {
        guard let url = URL(string: APIKey.baseURL) else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .emailValid(_):
            return "validation/email"
        case .join(email: _, password: _, nick: _):
            return "join"
        case .login(email: _, password: _):
            return "login"
        case .refresh(token: _, refreshToken: _):
            return "refresh"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .emailValid:
            return .post
        case .join:
            return.post
        case .login:
            return .post
        case .refresh:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .emailValid(let email):
            return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)
        case .join(email: let email, password: let password, nick: let nick):
            return .requestParameters(parameters: ["email": email, "password": password, "nick": nick], encoding: JSONEncoding.default)
        case .login(email: let email, password: let password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        case .refresh(token: _, refreshToken: _):
            return .requestPlain
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
    var headers: [String : String]? {
        switch self {
        case .emailValid, .join, .login:
            return ["Content-Type": "application/json",
                    "SesacKey": "\(APIKey.apiKey)"]
        case .refresh:
            return ["Authorization": KeyChain.shared.read(key: "access") ?? "",
                    "SesacKey": "\(APIKey.apiKey)",
                    "Refresh": KeyChain.shared.read(key: "refresh") ?? ""]
        }
        
    }
}

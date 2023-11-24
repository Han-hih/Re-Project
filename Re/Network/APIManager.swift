//
//  APIManager.swift
//  Re
//
//  Created by 황인호 on 11/21/23.
//

import Foundation
import Moya

enum APIManager {
    case emailValid(email: String)
    case join(email: String, password: String, nick: String)
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
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .emailValid(_):
            return .post
        case .join(email: _, password: _, nick: _):
            return.post
        }
    }
    
    var task: Task {
        switch self {
        case .emailValid(let email):
            return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)
        case .join(email: let email, password: let password, nick: let nick):
            return .requestParameters(parameters: ["email": email, "password": password, "nick": nick], encoding: JSONEncoding.default)
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json",
                "SesacKey": "\(APIKey.apiKey)"]
    }
}

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
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .emailValid(_):
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .emailValid(let email):
            return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json",
                "SesacKey": "\(APIKey.apiKey)"]
    }
}

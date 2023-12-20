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
    case refresh
    case post(Posting)
    case get(page: String)
    case postComment(id: String, comment: String)
    case getOnePost(id: String)
    case like(id: String)
    case getProfile
    case profileMod(MyInfo)
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
        case .refresh:
            return "refresh"
        case .post, .get:
            return "post"
        case .postComment(id: let id):
            return "post/\(id.id)/comment"
        case .getOnePost(id: let id):
            return "post/\(id)"
        case .like(id: let id):
            return "post/like/\(id)"
        case .profileMod, .getProfile:
            return "profile/me"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .emailValid, .join, .login, .post, .postComment, .like:
            return .post
        case .refresh, .get, .getOnePost, .getProfile:
            return .get
        case .profileMod:
            return .put
        }
    }
    
    var task: Task {
        switch self {
        case .emailValid(let email):
            return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)
        case .join(
            email: let email,
            password: let password,
            nick: let nick
        ):
            return .requestParameters(
                parameters: [
                    "email": email,
                    "password": password,
                    "nick": nick
                ],
                encoding: JSONEncoding.default
            )
            
        case .login(email: let email, password: let password):
            return .requestParameters(
                parameters: [
                    "email": email,
                    "password": password
                ],
                encoding: JSONEncoding.default
            )
        case .refresh, .getOnePost, .like, .getProfile:
            return .requestPlain
            
        case let .post(Posting):
            let titleProvider = MultipartFormData(provider: .data(Posting.title.data(using: .utf8) ?? Data()), name: "title")
            let contentProvider = MultipartFormData(provider: .data(Posting.content.data(using: .utf8) ?? Data()), name: "content")
            let creatorProvider = MultipartFormData(provider: .data(Posting.product_id.data(using: .utf8) ?? Data()), name: "product_id")
            let imageProvider = MultipartFormData(provider: .data(Posting.file ?? Data()), name: "file",fileName: "image.jpeg", mimeType: "image/jpeg")
            
            let multipartData = [titleProvider, contentProvider, creatorProvider, imageProvider]
            
            return .uploadMultipart(multipartData)
            
        case .get(page: let page):
            return .requestParameters(parameters: [
                "next": page,
                "limit": "10",
                "product_id": "\(APIKey.product_id)"
            ], encoding: URLEncoding.queryString)
            
        case .postComment(id: _, comment: let comment):
            return .requestParameters(
                parameters: ["content": comment],
                encoding: JSONEncoding.default
            )
    
        case let .profileMod(MyInfo):
            let nickProvider = MultipartFormData(provider: .data(MyInfo.nick.data(using: .utf8) ?? Data()), name: "nick")
            let profileProvider = MultipartFormData(provider: .data(MyInfo.profile ?? Data()), name: "profile")
            
            let multipartData = [nickProvider, profileProvider]
            
        return .uploadMultipart(multipartData)
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
        case .post, .profileMod:
            return ["Authorization": KeyChain.shared.read(key: "access") ?? "",
                    "Content-Type": "multipart/form-data",
                    "SesacKey": "\(APIKey.apiKey)"]
        case .get, .getOnePost, .like, .getProfile:
            return ["Authorization": KeyChain.shared.read(key: "access") ?? "",
                    "SesacKey": "\(APIKey.apiKey)"
            ]
        case .postComment:
            return [
                "Authorization": KeyChain.shared.read(key: "access") ?? "",
                "Content-Type": "application/json",
                "SesacKey": "\(APIKey.apiKey)"
            ]
        }
    }
}

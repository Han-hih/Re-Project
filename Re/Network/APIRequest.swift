//
//  APIRequest.swift
//  Re
//
//  Created by 황인호 on 11/23/23.
//

import Foundation
import RxSwift
import Moya

enum NetworkError: Int, Error {
    case valueEmpty = 400
    case invalidEmail = 409
    case decodingFailed = 999
    case unownedError = 1
}

final class APIRequest {
    
    static let shared = APIRequest()
    
    let service = MoyaProvider<APIManager>()
    
    func checkEmailDuplicate(email: String) -> Single<Result<EmailValidResult, NetworkError>> {
        return Single<Result<EmailValidResult, NetworkError>>.create { single in
            self.service.request(APIManager.emailValid(email: email)) { result in
                switch result {
                case .success(let response):
                    print(response.statusCode)
                    guard let data = try? JSONDecoder().decode(EmailValidResult.self, from: response.data) else
                    {
                        single(.success(.failure(.decodingFailed)))
                        return
                    }
                    single(.success(.success(data)))

                case .failure(let error):
                    guard let customError = NetworkError(rawValue: error.response?.statusCode ?? 1) else {
                        single(.success(.failure(NetworkError.unownedError)))
                        return
                    }
                    single(.success(.failure(customError)))
                }
            }
            return Disposables.create()
        }
    }
    
    
}

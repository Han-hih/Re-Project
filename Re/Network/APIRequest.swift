//
//  APIRequest.swift
//  Re
//
//  Created by 황인호 on 11/23/23.
//

import Foundation
import RxSwift
import Moya


final class APIRequest {
    
    static let shared = APIRequest()
    
   private let service = MoyaProvider<APIManager>(session: Moya.Session(interceptor: Interceptor.shared))
    
    
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
    
    func register(email: String, password: String, nick: String) -> Single<Result<JoinValidResult, NetworkError>> {
        return Single<Result<JoinValidResult, NetworkError>>.create { single in
            self.service.request(APIManager.join(email: email, password: password, nick: nick)) { result in
                switch result {
                case .success(let response):
                    guard let data = try? JSONDecoder().decode(JoinValidResult.self, from: response.data) else {
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
    
    func login(email: String, password: String) -> Single<Result<LoginValidResult, Error>> {
        return Single<Result<LoginValidResult, Error>>.create { single in
            self.service.request(APIManager.login(email: email, password: password)) { result in
                switch result {
                case .success(let response):
                    guard let data = try? JSONDecoder().decode(LoginValidResult.self, from: response.data) else {
                        single(.success(.failure(NetworkError.decodingFailed)))
                        return
                    }
                    single(.success(.success(data)))
                case .failure(let error):
                    guard let customError = NetworkError(rawValue: error.response?.statusCode ?? 1) else {
                        single(.success(.failure(LoginError.unsignedValue)))
                        return
                    }
                    single(.success(.failure(customError)))
                }
            }
            return Disposables.create()
        }
    }
    
    func refreshToken(token: String, refreshToken: String) -> Single<Result<RefreshToken, Error>> {
        return Single<Result<RefreshToken, Error>>.create { single in
            self.service.request(APIManager.refresh(token: token, refreshToken: refreshToken)) { result in
                switch result {
                case .success(let response):
                    guard let data = try? JSONDecoder().decode(RefreshToken.self, from: response.data) else {
                        single(.success(.failure(NetworkError.decodingFailed)))
                        return
                    }
                    single(.success(.success(data)))
                case .failure(let error):
                    guard let customError = NetworkError(rawValue: error.response?.statusCode ?? 1) else {
                        single(.success(.failure(LoginError.unsignedValue)))
                        return
                    }
                    single(.success(.failure(customError)))
                }
            }
            return Disposables.create()
        }
        
    }
    
}

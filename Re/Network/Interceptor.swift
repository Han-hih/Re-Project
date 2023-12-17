//
//  Interceptor.swift
//  Re
//
//  Created by 황인호 on 11/28/23.
//

import Alamofire
import Moya
import RxSwift
import UIKit

final class Interceptor: RequestInterceptor {
    
    static let shared = Interceptor()
    private let disposeBag = DisposeBag()
    
    private init() { }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix("\(APIKey.baseURL)") == true,
              let accessToken = KeyChain.shared.read(key: "access"), // 기기에 저장된 토큰들
              let refreshToken = KeyChain.shared.read(key: "refresh")
        else {
            completion(.success(urlRequest))
            return
        }
        
        var urlRequest = urlRequest
        urlRequest.setValue(accessToken, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(refreshToken, forHTTPHeaderField: "Refresh")
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("retry 진입")
            guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 419
        else {
            completion(.doNotRetryWithError(error))
            return
        }
        APIRequest.shared.refreshToken()
    }
}
    

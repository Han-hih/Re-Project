//
//  Interceptor.swift
//  Re
//
//  Created by 황인호 on 11/28/23.
//

import Foundation
import Alamofire
import Moya
import RxSwift

final class Interceptor: RequestInterceptor {
    
    static let shared = Interceptor()
    
//    private let service = MoyaProvider<APIManager>()
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
        print("adator 적용 \(urlRequest.headers)")
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("retry 진입")
            guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 419, response.statusCode == 418
        else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        
        guard let accessToken = KeyChain.shared.read(key: "access") else { return }
        guard let refreshToken = KeyChain.shared.read(key: "refresh") else { return }
        // 토큰 갱신 API 호출
        APIRequest.shared.refreshToken(token: accessToken, refreshToken: refreshToken)
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let token):
                    print("리트라이 성공  \(token)")
                    completion(.retry)
                case .failure(let error):
                    completion(.doNotRetryWithError(error))
                }
            }
            .disposed(by: disposeBag)
    }
}
    

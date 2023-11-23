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
    
     let service = MoyaProvider<APIManager>()
    
    func checkEmailDuplicate(email: String) -> Single<EmailValidResult> {
        return Single<EmailValidResult>.create { single in
            self.service.request(APIManager.emailValid(email: email)) { result in
                switch result {
                case .success(let element):
                    guard let data = try? element.map(EmailValidResult.self) else { return }
                    single(.success(data))
                case .failure(let error):
                    print(error)
                }
            }
            return Disposables.create()
        }
    }
    
}

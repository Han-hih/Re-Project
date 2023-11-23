//
//  RegisterViewModel.swift
//  Re
//
//  Created by 황인호 on 11/20/23.
//

import Foundation
import RxSwift
import Moya

final class RegisterViewModel: ViewModelType {
    
    private let service = MoyaProvider<APIManager>()
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let emailValid: Observable<String>
        let passwordValid: Observable<String>
        let emailDuplicateTap: Observable<Void>
    }
    
    struct Output {
        let emailValid: Observable<Bool>
        let passwordValid: Observable<Bool>
        let emailDuplicateTap: PublishSubject<EmailValidResult>
    }
    
    func transform(input: Input) -> Output {
        
        let emailDuplicateTap = PublishSubject<EmailValidResult>()
        
        let emailValid = input.emailValid.map { ValidationCheck().isValidEmail($0)
        }
        
        let passwordValid = input.passwordValid.map { ValidationCheck().validatePassword($0)
        }
        
        input.emailDuplicateTap
            .withLatestFrom(input.emailValid) { _, query in
                return query
            }
            .flatMap { self.checkEmailDuplicate(email: $0) }
            .subscribe(with: self) { owner, value in
                print(value)
                emailDuplicateTap.onNext(value)
            }
            .disposed(by: disposeBag)
        
        return Output(emailValid: emailValid,
                      passwordValid: passwordValid,
                      emailDuplicateTap: emailDuplicateTap
        )
    }
    
    private func checkEmailDuplicate(email: String) -> Single<EmailValidResult> {
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




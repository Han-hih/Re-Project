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
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let emailValid: Observable<String>
        let passwordValid: Observable<String>
        let emailDuplicateTap: Observable<Void>
        let nicknameValid: Observable<String>
    }
    
    struct Output {
        let emailValid: Observable<Bool>
        let passwordValid: Observable<Bool>
        let nicknameValid: Observable<Bool>
        let emailDuplicateTap: PublishSubject<Bool>
        let emailDuplicateError: PublishSubject<Bool>
        let joinValid: Observable<Bool>
        
        
    }
    
    func transform(input: Input) -> Output {
        
        let emailDuplicateTap = PublishSubject<Bool>()
        
        let emailDuplicateError = PublishSubject<Bool>()
        
        let emailValid = input.emailValid.map { ValidationCheck().isValidEmail($0)
        }
        
        let passwordValid = input.passwordValid.map { ValidationCheck().validatePassword($0)
        }
    
        let nicknameValid = input.nicknameValid.map { $0.count >= 3}
        
        input.emailDuplicateTap
            .withLatestFrom(input.emailValid) { _, query in
                return query
            }
            .flatMap {
                let result = APIRequest.shared.checkEmailDuplicate(email: $0)
                return result
            }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(_):
                    emailDuplicateTap.onNext(true)
                case .failure(_):
                    emailDuplicateTap.onNext(false)
                }
            }
            .disposed(by: disposeBag)
        
        let joinValid = Observable.combineLatest(emailValid,  emailDuplicateTap.asObservable(), passwordValid, nicknameValid) { (firstbool, emailbool, pwbool, nickbool) -> Bool in
            if emailbool && pwbool && nickbool == true {
                print("true")
                return true
            } else {
                print("false")
                return false
            }
        }
        
        return Output(emailValid: emailValid,
                      passwordValid: passwordValid, 
                      nicknameValid: nicknameValid,
                      emailDuplicateTap: emailDuplicateTap,
                      emailDuplicateError: emailDuplicateError, joinValid: joinValid
        )
    }
    
    
    
    
    
}




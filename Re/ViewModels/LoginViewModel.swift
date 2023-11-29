//
//  LoginViewModel.swift
//  Re
//
//  Created by 황인호 on 11/25/23.
//

import Foundation
import RxSwift

class LoginViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()
    private let userdefaults = UserDefaults()
    
    struct Input {
        let emailTextEmpty: Observable<String>
        let passwordTextEmpty: Observable<String>
        let loginButtonTap: Observable<Void>
        
    }
    
    struct Output {
        let emailTextEmpty: Observable<Bool>
        let passwordTextEmpty: Observable<Bool>
        
        let loginValid: Observable<Bool>
        let loginButtonTap: Observable<Bool>
        
    }
    
    func transform(input: Input) -> Output {
        let emailTextEmpty = input.emailTextEmpty.map { $0.count == 0 }
            
        let passwordTextEmpty = input.passwordTextEmpty.map { $0.count == 0 }
        
        let loginButtonTap = PublishSubject<Bool>()
        
        let loginValid = Observable.combineLatest(emailTextEmpty, passwordTextEmpty, resultSelector: { (email, password) -> Bool in
            if !email && !password {
                
                return true
                
            } else {
                print("no")
                return false
                
            }
        })
        
        input.loginButtonTap
            .withLatestFrom(Observable.combineLatest(input.emailTextEmpty, input.passwordTextEmpty))
            .flatMapLatest { (email, password) in
                APIRequest.shared.login(email: email, password: password)
            }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let response):
                    KeyChain.shared.create(key: "access", token: response.token)
                    KeyChain.shared.create(key: "refresh", token: response.refreshToken)
                    owner.userdefaults.set(true, forKey: "isLogin")
                    loginButtonTap.onNext(true)
                case .failure(let error):
                    print("로그인 실패")
                    print(error)
                    loginButtonTap.onNext(false)
                }
            }
            .disposed(by: disposeBag)
        
        
        let loginValue = Observable.combineLatest(loginButtonTap, input.emailTextEmpty, input.passwordTextEmpty)
        
        loginValue.subscribe(with: self) { owner , value in
            if value.0 == true {
                owner.userdefaults.set(value.1, forKey: "email")
                owner.userdefaults.set(value.2, forKey: "pw")
            }
        }
        .disposed(by: disposeBag)
   
        return Output(emailTextEmpty: emailTextEmpty,
                      passwordTextEmpty: passwordTextEmpty,
                      loginValid: loginValid,
                      loginButtonTap: loginButtonTap
        )
    }
}

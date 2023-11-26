//
//  LoginViewModel.swift
//  Re
//
//  Created by 황인호 on 11/25/23.
//

import Foundation
import RxSwift

class LoginViewModel: ViewModelType {
    
    
    
    struct Input {
        let emailTextEmpty: Observable<String>
        let passwordTextEmpty: Observable<String>
        let loginButtonTap: Observable<Void>
        
    }
    
    struct Output {
        let emailTextEmpty: Observable<Bool>
        let passwordTextEmpty: Observable<Bool>
        
        let loginValid: Observable<Bool>
        let loginButtonTap: Observable<Void>
        
    }
    
    func transform(input: Input) -> Output {
        let emailTextEmpty = input.emailTextEmpty.map { $0.count == 0 }
            
        let passwordTextEmpty = input.passwordTextEmpty.map { $0.count == 0 }
        
        let loginValid = Observable.combineLatest(emailTextEmpty, passwordTextEmpty, resultSelector: { (email, password) -> Bool in
            if !email && !password {
                
                return true
                
            } else {
                print("no")
                return false
                
            }
        })
        
        let loginButtonTap = input.loginButtonTap
        
        return Output(emailTextEmpty: emailTextEmpty,
                      passwordTextEmpty: passwordTextEmpty,
                      loginValid: loginValid,
                      loginButtonTap: loginButtonTap
        )
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}

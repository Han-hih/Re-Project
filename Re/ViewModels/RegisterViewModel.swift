//
//  RegisterViewModel.swift
//  Re
//
//  Created by 황인호 on 11/20/23.
//

import Foundation
import RxSwift

final class RegisterViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let emailValid: Observable<String>
        let passwordValid: Observable<String>
    }
    
    struct Output {
        let emailValid: Observable<Bool>
        let passwordValid: Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        
        let emailValid = input.emailValid.map { ValidationCheck().isValidEmail($0)
        }
        
        let passwordValid = input.passwordValid.map { ValidationCheck().validatePassword($0)
        }
        
        return Output(emailValid: emailValid, passwordValid: passwordValid)
    }
    
}

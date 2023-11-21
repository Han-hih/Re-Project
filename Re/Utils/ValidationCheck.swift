//
//  Validation.swift
//  Re
//
//  Created by 황인호 on 11/20/23.
//

import Foundation

final class ValidationCheck {
    // 이메일 정규성 체크
    func isValidEmail(_ input: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,30}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: input)
    }
    
    // 패스워드 정규성 체크
    func validatePassword(_ input: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,20}" // 8자리 ~ 20자리 영어+숫자+특수문자
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: input)
    }
    
    // 핸드폰 번호 정규성 체크
    func validatePhoneNumber(_ input: String) -> Bool {
        let phoneRegax = "^010[0-9]{7,8}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegax)
        return phoneTest.evaluate(with: input)
    }
}

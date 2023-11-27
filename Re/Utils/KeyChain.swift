//
//  KeyChain.swift
//  Re
//
//  Created by 황인호 on 11/27/23.
//

import Foundation
import Security

final class KeyChain {

    static let shared = KeyChain()
    
    func create(key: String, token: String) {
        let addQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: token.data(using: .utf8, allowLossyConversion: false) as Any
        ]
        SecItemDelete(addQuery)
//        SecItemAdd(addQuery, nil)
        let status: OSStatus = SecItemAdd(addQuery, nil)
        assert(status == noErr, "토큰 값 저장에 실패했습니다.")
        NSLog("status = \(status)")
    }
        
    
    
    
    
    
}

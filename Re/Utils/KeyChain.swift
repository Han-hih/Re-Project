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
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: token.data(using: .utf8, allowLossyConversion: false) as Any
        ]
        SecItemDelete(query)
        let status = SecItemAdd(query, nil)
          assert(status == noErr, "failed to save Token")
    }
        
    func read(key: String) -> String? {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)
        
        if (status == errSecSuccess) {
            let retrievedData = dataTypeRef as! Data
            let value = String(data: retrievedData, encoding: String.Encoding.utf8)
            return value
        } else {
            print("failed = \(status)")
            return  nil
        }
        
    }
    
    class func delete(key: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
        let status = SecItemDelete(query)
        assert(status == noErr, "failed to delete the value, status code = \(status)")
    }
    
}

//
//  HomeViewModel.swift
//  Re
//
//  Created by 황인호 on 11/29/23.
//

import Foundation
import Kingfisher

final class HomeViewModel {
    
    var nextCursor: String?
    
    var getData: getTest? = nil
    
    func getPost(completion: @escaping () -> Void) {
        APIRequest.shared.getPost { result in
            self.getData = result
            completion()
        }
    }
    
    let modifier = AnyModifier { request in
        var request = request
        request.setValue(KeyChain.shared.read(key: "access") ?? "", forHTTPHeaderField: "Authorization")
        request.setValue(APIKey.apiKey, forHTTPHeaderField: "SesacKey")
        return request
    }
    
    
}

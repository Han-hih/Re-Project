//
//  HomeViewModel.swift
//  Re
//
//  Created by 황인호 on 11/29/23.
//

import Foundation
import Kingfisher

final class HomeViewModel {
    
    var nextCursor: String? = ""
    
    var getData = [Datum?]()

    func getPost(completion: @escaping () -> Void) {
        guard let next = self.nextCursor else { return }
        APIRequest.shared.getPost(page: self.nextCursor ?? "") { result in
            guard let result = result else { return }
            if next != "0" {
                self.nextCursor = result.nextCursor
                self.getData.append(contentsOf: result.data)
                completion()
            } else if next == "0" {
                print("끝")
            }
        }
    }
    
    let modifier = AnyModifier { request in
        var request = request
        request.setValue(KeyChain.shared.read(key: "access") ?? "", forHTTPHeaderField: "Authorization")
        request.setValue(APIKey.apiKey, forHTTPHeaderField: "SesacKey")
        return request
    }
    
    
    
    
    
}

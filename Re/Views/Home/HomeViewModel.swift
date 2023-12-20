//
//  HomeViewModel.swift
//  Re
//
//  Created by 황인호 on 11/29/23.
//

import Foundation
import Kingfisher

final class HomeViewModel {
    
    var next: String? = ""
    
    var getData = [Datum?]()
    
    func getgetPost(completion: @escaping () -> Void) {
        APIRequest.shared.apiRequest(APIManager.get(page: next ?? ""), type: GetTest.self) { result in
            switch result {
            case .success(let response):
                if self.next ?? "" != "0" {
                    self.next = response.nextCursor
                    self.getData.append(contentsOf: response.data)
                    print(self.next)
                    completion()
                } else if self.next ?? "" == "0" {
                    print("끝")
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}


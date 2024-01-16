//
//  MyProfileViewModel.swift
//  Re
//
//  Created by 황인호 on 2/12/24.
//

import Foundation

class MyProfileViewModel {
    
    var next: String? = ""
    
    var getData = [Datum?]()
    
    func lookUpMyPost(id: String, completion: @escaping () -> Void) {
        APIRequest.shared.apiRequest(.MyPost(id: id, page: next ?? ""), type: GetTest.self) { result in
            switch result {
            case .success(let response):
                if self.next ?? "" != "0" {
                    self.next = response.nextCursor
                    self.getData.append(contentsOf: response.data)
                    completion()
                } else if self.next ?? "" == "0" {
                    print("끝")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}

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

    func getgetPost(completion: @escaping () -> Void) {
        guard let next = self.nextCursor else { return }
        APIRequest.shared.apiRequest(APIManager.get(page: self.nextCursor ?? ""), type: GetTest.self) { result in
            switch result {
            case .success(let response):
                if next != "0" {
                    self.nextCursor = response.nextCursor
                    self.getData.append(contentsOf: response.data)
                    completion()
                } else if next == "0" {
                    print("끝")
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

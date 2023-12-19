//
//  HomeDetail\ViewModel.swift
//  Re
//
//  Created by 황인호 on 12/13/23.
//

import Foundation

class HomeDetailViewModel {
    
    var detail: Datum?
    
    func LikeButtonTapped(id: String, completion: @escaping (Like) -> Void) {
        APIRequest.shared.apiRequest(APIManager.like(id: id), type: Like.self) { result in
            switch result {
            case .success(let response):
                print(response.like_status)
                completion(response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getOnePost(id: String) {
        APIRequest.shared.apiRequest(APIManager.getOnePost(id: id), type: Datum.self) { result in
            switch result {
            case .success(let response):
                self.detail = response
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
}

//
//  CommentViewModel.swift
//  Re
//
//  Created by 황인호 on 12/16/23.
//

import Foundation

class CommentViewModel {
    
    var postComments = [Comment]()
    
    func postComment(id: String, comment: String, completion: @escaping () -> Void) {
        APIRequest.shared.apiRequest(
            APIManager.postComment(id: id, comment: comment),
            type: Comment.self) { result in
                switch result {
                case .success(let response):
                    print(response)
                    completion()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
  
     func getOnePost(id: String, completion: @escaping () -> Void) {
        APIRequest.shared.apiRequest(APIManager.getOnePost(id: id), type: Datum.self) { result in
            switch result {
            case .success(let response):
                self.postComments.append(contentsOf: response.comments)
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
}

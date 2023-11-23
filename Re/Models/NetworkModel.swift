//
//  NetworkModel.swift
//  Re
//
//  Created by 황인호 on 11/22/23.
//

import Foundation

struct EmailValidResult: Codable {
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<EmailValidResult.CodingKeys> = try decoder.container(keyedBy: EmailValidResult.CodingKeys.self)
        self.message = try container.decode(String.self, forKey: EmailValidResult.CodingKeys.message)
    }
}

//
//  Protocols.swift
//  Re
//
//  Created by 황인호 on 11/21/23.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

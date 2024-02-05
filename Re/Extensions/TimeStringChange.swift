//
//  TimeStringChange.swift
//  Re
//
//  Created by 황인호 on 2/5/24.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: self)
    }
    
    func toFormattedString() -> String? {
        guard let date = self.toDate() else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일  HH:mm"
        return dateFormatter.string(from: date)
    }
}

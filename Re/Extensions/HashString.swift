//
//  HashString.swift
//  Re
//
//  Created by 황인호 on 2/12/24.
//

import UIKit

extension UILabel {
    func hashString() {
        guard let hashText = self.text else { return }
        
        let attributedString = NSMutableAttributedString(string: hashText)
        
        let regex = try! NSRegularExpression(pattern: "#\\w+")
        let hashLabel = regex.matches(in: hashText, range: NSRange(location: 0, length: attributedString.length))
        
        for hash in hashLabel {
            attributedString.addAttribute(.foregroundColor, value: Color.point.uiColor, range: hash.range)
        }
        
        self.attributedText = attributedString   
    }
}

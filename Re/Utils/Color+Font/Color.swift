//
//  Color.swift
//  Re
//
//  Created by 황인호 on 11/20/23.
//

import UIKit

enum Color {
    case point
    case fail
    case placeholder
    
    var uiColor: UIColor {
        switch self {
        case .point: return .systemPurple
        case .fail: return UIColor.red
        case .placeholder: return .lightGray
        }
    }
}

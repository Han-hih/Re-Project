//
//  ReusableViewProtocol.swift
//  Re
//
//  Created by 황인호 on 12/7/23.
//

import UIKit

protocol ReusableViewProtocol {
    static var identifier: String { get }
}

extension UICollectionViewCell: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

//
//  CustomButton.swift
//  Re
//
//  Created by 황인호 on 12/2/23.
//

import UIKit

final class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButton() {
        tintColor = Color.point.uiColor
    }
}

//
//  CustomTextField.swift
//  Re
//
//  Created by 황인호 on 11/19/23.
//

import UIKit
import TextFieldEffects

final class CustomTextField: HoshiTextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTextField() {
        placeholderColor = Color.placeholder.uiColor
        borderActiveColor = Color.point.uiColor
        borderInactiveColor = Color.placeholder.uiColor
        placeholderFontScale = 0.8
        returnKeyType = .next
    }
    
    
}


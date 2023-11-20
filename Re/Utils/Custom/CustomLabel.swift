//
//  CustomLabel.swift
//  Re
//
//  Created by 황인호 on 11/20/23.
//

import UIKit

final class CustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLabel() {
        font = .systemFont(ofSize: 12)
    }
}

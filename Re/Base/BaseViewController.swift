//
//  BaseViewController.swift
//  Re
//
//  Created by 황인호 on 11/18/23.
//

import UIKit
import RxSwift
import RxCocoa

import Then
import SnapKit

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setConstraints()
    }
    
    func configure() {
        
    }
    
    func setConstraints() {}
}



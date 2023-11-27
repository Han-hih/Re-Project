//
//  HomeViewController.swift
//  Re
//
//  Created by 황인호 on 11/26/23.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    override func configure() {
        super.configure()
       
    }
    
    override func setConstraints() {
        super.setConstraints()
        setNavigation()
    }
    
   private func setNavigation() {
       let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.text = "RE"
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "로그인을 해주세요", style: .done, target: self, action: #selector(loginButtonTapped))
    }
    
    @objc func loginButtonTapped() {
        let vc = LoginViewContoller()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

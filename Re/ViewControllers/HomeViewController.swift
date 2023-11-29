//
//  HomeViewController.swift
//  Re
//
//  Created by 황인호 on 11/26/23.
//

import UIKit
import RxSwift
import Moya


final class HomeViewController: BaseViewController {
    
    private let service = MoyaProvider<APIManager>()
    private let userdefaults = UserDefaults()
    
    override func configure() {
        super.configure()
        check()
//        autoLogin()

        
    }
    
    override func setConstraints() {
        super.setConstraints()
        setNavigation()
    }
    
    private func check() {
        guard let access = KeyChain.shared.read(key: "access") else { return }
        guard let refresh = KeyChain.shared.read(key: "refresh") else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)  {
            if (KeyChain.shared.read(key: "access") != nil)  {
                APIRequest.shared.refreshToken(token: access, refreshToken: refresh)
                    .subscribe(with: self) { owner, result in
                        print(result)
                    } onFailure: { owner, error in
                        print(error, "jijjhjyhjhjhj")
                    }
                    .disposed(by: self.disposeBag)
            } else {
                print("토큰없음")
            }
        }
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

//
//  RegisterViewController.swift
//  Re
//
//  Created by 황인호 on 11/19/23.
//

import UIKit
import RxSwift
import RxCocoa

final class RegisterViewController: BaseViewController {
    
    let viewModel = RegisterViewModel()
    
    override func configure() {
        super.configure()
        bind()
    }
    
    override func setConstraints() {
        super.setConstraints()
        setUI()
        
    }
    
    private func bind() {
        
    }
    
    private func setUI() {
        view.addSubview(stackView)
        [emailTextField, emailCheckButton, emailValidLabel, passwordTextField, passwordValidLabel, nicknameTextField, registerButton].forEach {
            stackView.addSubview($0)
        }
        
        stackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.7)
        }
        emailTextField.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.75)
            $0.top.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        emailCheckButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.25)
            $0.centerY.equalTo(emailTextField.snp.centerY)
            $0.height.equalTo(30)
            $0.leading.equalTo(emailTextField.snp.trailing)
        }
        
        emailValidLabel.snp.makeConstraints {
            $0.leading.equalTo(emailTextField.snp.leading)
            $0.top.equalTo(emailTextField.snp.bottom).offset(5)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
            $0.top.equalTo(emailTextField.snp.bottom).offset(30)
        }
        
        passwordValidLabel.snp.makeConstraints {
            $0.leading.equalTo(passwordTextField.snp.leading)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(5)
        }
        
//        checkPasswordTextField.snp.makeConstraints {
//            $0.width.equalToSuperview()
//            $0.height.equalTo(50)
//            $0.top.equalTo(passwordTextField.snp.bottom).offset(30)
//        }
//        
//        checkPasswordValidLabel.snp.makeConstraints {
//            $0.leading.equalTo(checkPasswordTextField.snp.leading)
//            $0.top.equalTo(checkPasswordTextField.snp.bottom).offset(5)
//        }
        
        nicknameTextField.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(30)
        }
        
        registerButton.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(30)
        }
        
    }
    
    
    private let stackView = {
        let view = UIStackView()
        view.spacing = 30
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fillEqually
        return view
    }()
    
    private let emailTextField = {
        let text = CustomTextField()
        text.placeholder = "* 이메일 입력(알파벳, 숫자, @,. 포함)"
        
        return text
    }()
    
    private let emailValidLabel = {
        let label = CustomLabel()
        return label
    }()
    
    
    private let emailCheckButton = {
        let bt = UIButton()
        bt.setTitle("중복 확인", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        bt.titleLabel?.font = .systemFont(ofSize: 14)
        bt.layer.borderColor = UIColor.systemPurple.cgColor
        bt.layer.borderWidth = 1
        bt.layer.cornerRadius = 10
        bt.clipsToBounds = true
        return bt
    }()
    
    private let passwordTextField = {
        let text = CustomTextField()
        text.placeholder = "* 비밀번호 입력(문자, 숫자, 특수문자 포함 8~20자)"
        return text
    }()
    
    private let passwordValidLabel = {
        let label = CustomLabel()
        return label
    }()
    
//    private let checkPasswordTextField = {
//        let text = CustomTextField()
//        text.placeholder = "* 비밀번호 확인"
//        return text
//    }()
//    
//    private let checkPasswordValidLabel = {
//        let label = CustomLabel()
//        return label
//    }()
    
    private let nicknameTextField = {
        let text = CustomTextField()
        text.placeholder = "* 닉네임 입력"
        return text
    }()
    
    private let registerButton = {
        let bt = UIButton()
        bt.setTitle("회원가입하기", for: .normal)
        bt.backgroundColor = .systemPurple
        return bt
    }()

}

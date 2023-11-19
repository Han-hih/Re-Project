//
//  ViewController.swift
//  Re
//
//  Created by 황인호 on 11/18/23.
//

import UIKit

final class LoginViewContoller: BaseViewController {

    override func configure() {
        super.configure()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    
    override func setConstraints() {
        super.setConstraints()
        setUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func setUI() {
        view.addSubview(stackView)
        view.addSubview(registerButton)
        [emailTextField, passwordTextField, loginButton].forEach {
            stackView.addSubview($0)
        }
        stackView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.25)
            $0.centerX.centerY.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
        }
    
        registerButton.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(10)
            $0.centerX.equalTo(view.snp.centerX)
        }
    }
    
    private let stackView = {
        let view = UIStackView()
        view.spacing = 20
        view.alignment = .fill
        view.axis = .vertical
        view.backgroundColor = .white
        return view
    }()
    
    private let emailTextField = {
        let text = CustomTextField()
        text.placeholder = " 이메일을 입력해 주세요"
        text.returnKeyType = .next
        return text
    }()
    
    private let passwordTextField = {
        let text = CustomTextField()
        text.placeholder = " 비밀번호를 입력해 주세요"
        text.returnKeyType = .done
        return text
    }()
    
    private let loginButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.backgroundColor = .systemCyan
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(LoginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let registerButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.addTarget(self, action: #selector(RegisterButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func LoginButtonTapped() {
        print("로그인이 되었습니다.")
    }
    
    @objc func RegisterButtonTapped() {
        print("회원가입")
        
    }
}

extension LoginViewContoller: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}

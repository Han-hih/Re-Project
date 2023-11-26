//
//  ViewController.swift
//  Re
//
//  Created by 황인호 on 11/18/23.
//

import UIKit

final class LoginViewContoller: BaseViewController {
    
    let viewModel = LoginViewModel()
    
    override func configure() {
        super.configure()
        bind()
    }
    
    
    override func setConstraints() {
        super.setConstraints()
        setUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func bind() {
        let input = LoginViewModel.Input(emailTextEmpty: emailTextField.rx.text.orEmpty.asObservable(), passwordTextEmpty: passwordTextField.rx.text.orEmpty.asObservable(), loginButtonTap: loginButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.emailTextEmpty.bind { bool in
            print(bool ? "dd" : "ggh")
        }
        .disposed(by: disposeBag)
        
        output.passwordTextEmpty.bind(with: self) { owner, value in
            print(value ? "pass" : "non")
        }
        .disposed(by: disposeBag)
        
        output.loginValid.bind(with: self, onNext: { owner, bool in
            owner.loginButton.backgroundColor = bool ? .systemPurple.withAlphaComponent(1) : .systemPurple.withAlphaComponent(0.3)
            owner.loginButton.isEnabled = bool ? true : false
            
        })
        .disposed(by: disposeBag)
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
        return text
    }()
    
    private let passwordTextField = {
        let text = CustomTextField()
        text.placeholder = " 비밀번호를 입력해 주세요"
        text.returnKeyType = .done
        return text
    }()
    
    private lazy var loginButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.backgroundColor = .systemPurple
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(LoginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerButton = {
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
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

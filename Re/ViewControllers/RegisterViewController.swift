//
//  RegisterViewController.swift
//  Re
//
//  Created by 황인호 on 11/19/23.
//

import UIKit

final class RegisterViewController: BaseViewController {
    
    override func configure() {
        super.configure()
    }
    
    override func setConstraints() {
        super.setConstraints()
        setUI()
        setupDatePicker()
        setDelegate()
        
    }
    
    private func setDelegate() {
        [emailTextField, passwordTextField, checkPasswordTextField, nicknameTextField, phoneTextField, birthdayTextField].forEach {
            $0.delegate = self
        }
    }
    
    private func setUI() {
        view.addSubview(stackView)
        [emailTextField, emailCheckButton, emailValidLabel, passwordTextField, passwordValidLabel,  checkPasswordTextField, checkPasswordValidLabel, nicknameTextField, phoneTextField, birthdayTextField, registerButton].forEach {
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

        //
        //        atLabel.snp.makeConstraints {
        //            $0.top.equalTo(emailTextField.snp.bottom).offset(30)
        //            $0.leading.equalToSuperview()
        //        }
        //
        //        domainTextField.snp.makeConstraints {
        //            $0.top.equalTo(emailTextField.snp.bottom)
        //            $0.leading.equalTo(atLabel.snp.trailing).offset(10)
        //            $0.height.equalTo(50)
        //        }
        
        passwordTextField.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
            $0.top.equalTo(emailTextField.snp.bottom).offset(30)
        }
        
        passwordValidLabel.snp.makeConstraints {
            $0.leading.equalTo(passwordTextField.snp.leading)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(5)
        }
        
        checkPasswordTextField.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(30)
        }
        
        checkPasswordValidLabel.snp.makeConstraints {
            $0.leading.equalTo(checkPasswordTextField.snp.leading)
            $0.top.equalTo(checkPasswordTextField.snp.bottom).offset(5)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
            $0.top.equalTo(checkPasswordTextField.snp.bottom).offset(30)
        }
        
        phoneTextField.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(30)
        }
        
        birthdayTextField.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
            $0.top.equalTo(phoneTextField.snp.bottom).offset(30)
        }
        
        registerButton.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
            $0.top.equalTo(birthdayTextField.snp.bottom).offset(30)
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
        text.placeholder = "이메일 입력(알파벳, 숫자, @,. 포함)"
        
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
    
    //    private let atLabel = {
    //        let label = UILabel()
    //        label.text = "@"
    //        return label
    //    }()
    
    //    private let domainTextField = {
    //        let text = CustomTextField()
    ////        text.placeholder = "주소값을 입력"
    //        text.text = "naver.com"
    //        return text
    //    }()
    
    private let passwordTextField = {
        let text = CustomTextField()
        text.placeholder = "비밀번호 입력(문자, 숫자, 특수문자 포함 8~20자)"
        
        return text
    }()
    
    private let passwordValidLabel = {
        let label = CustomLabel()
        return label
    }()
    
    private let checkPasswordTextField = {
        let text = CustomTextField()
        text.placeholder = "비밀번호 확인"
        return text
    }()
    
    private let checkPasswordValidLabel = {
        let label = CustomLabel()
        label.text = "비밀번호가 일치하지 않습니다"
        return label
    }()
    
    private let nicknameTextField = {
        let text = CustomTextField()
        text.placeholder = "닉네임 입력"
        return text
    }()
    
    private let phoneTextField = {
        let text = CustomTextField()
        text.placeholder = "핸드폰 번호 입력(-제외)"
        return text
    }()
    
    private let birthdayTextField = {
        let text = CustomTextField()
        text.placeholder = "생년월일 입력"
        text.returnKeyType = .done
        return text
    }()
    
    private let registerButton = {
        let bt = UIButton()
        bt.setTitle("회원가입하기", for: .normal)
        bt.backgroundColor = .systemPurple
        return bt
    }()
    
    private func setupDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        datePicker.sizeToFit()
        
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(cancelButtonTapped))
        toolbar.setItems([cancelButton, flexibleSpace ,doneButton], animated: true)
        birthdayTextField.inputAccessoryView = toolbar
        birthdayTextField.inputView = datePicker
    }
    
    @objc func cancelButtonTapped() {
        self.view.endEditing(true)
        birthdayTextField.text = ""
    }
    
    @objc func doneButtonPressed() {
        //        print(sender.date)
        //        birthdayTextField.text = dateFormatter(date: sender.date)
        self.view.endEditing(true)
    }
    
    @objc func dateChange(_ sender: UIDatePicker) {
        sender.rx.date
            .bind { date in
                self.birthdayTextField.text = self.dateFormatter(date: date)
            }
            .disposed(by: disposeBag)
    }
    
    func dateFormatter(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: date)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            textField.resignFirstResponder()
            checkPasswordTextField.becomeFirstResponder()
        case checkPasswordTextField:
            textField.resignFirstResponder()
            nicknameTextField.becomeFirstResponder()
        case nicknameTextField:
            textField.resignFirstResponder()
            phoneTextField.becomeFirstResponder()
        case phoneTextField:
            textField.resignFirstResponder()
            birthdayTextField.becomeFirstResponder()
        case birthdayTextField:
            textField.resignFirstResponder()
        default: break
        }
        return true
    }
}

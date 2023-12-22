//
//  ProfileModifyViewController.swift
//  Re
//
//  Created by 황인호 on 12/21/23.
//

import UIKit

class ProfileModifyViewController: BaseViewController {
    
    var nickname: String?
    
    override func setConstraints() {
        super.setConstraints()
        setNavi()
        setUI()
    }
    
    override func configure() {
        super.configure()
        imageViewTapped()
    }
    
    private func imageViewTapped() {
        self.profileImageView.isUserInteractionEnabled = true
        self.profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageButtonTapped)))
    }
    
    private func setNavi() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(saveButtonTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = Color.point.uiColor
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style:  .done, target: self, action: #selector(xButtonTapped))
        self.navigationItem.leftBarButtonItem?.tintColor = Color.point.uiColor
    }
    
    @objc
    func saveButtonTapped() {
        APIRequest.shared.apiRequest(APIManager.profileMod(MyInfo(nick: nickTextField.text ?? "", profile: profileImageView.image?.jpegData(compressionQuality: 0.1))), type: MyInfo.self) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
        dismiss(animated: true)
    }
    
    @objc
    func xButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc
    func imageButtonTapped() {
        print("사진창 열림")
    }
    
    private func setUI() {
        [profileImageView, nickTextField, nickTestLabel].forEach {
            view.addSubview($0)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalTo(view.snp.centerX)
            $0.size.equalTo(150)
        }
        
        nickTextField.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(40)
            $0.horizontalEdges.equalTo(view).inset(20)
            $0.height.equalTo(60)
        }
        
        nickTestLabel.snp.makeConstraints {
            $0.top.equalTo(nickTextField.snp.bottom).offset(5)
            $0.horizontalEdges.equalTo(nickTextField)
        }
        
        nickTextField.text = nickname
        
    }
    
    private let profileImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 75
        view.clipsToBounds = true
        return view
    }()
    
    private let nickTextField = {
        let tf = CustomTextField()
        tf.placeholder = "변경할 닉네임을 입력해 주세요."
        
        return tf
    }()
    
    private let nickTestLabel = {
        let lb = CustomLabel()
        lb.text = "닉네임은 2자에서 8자 이내로 작성해 주세요."
        lb.textColor = .lightGray
        return lb
    }()
    
}

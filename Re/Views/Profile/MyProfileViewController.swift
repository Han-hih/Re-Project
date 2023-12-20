//
//  CommunityViewController.swift
//  Re
//
//  Created by 황인호 on 11/27/23.
//

import UIKit

class MyProfileViewController: BaseViewController {
   
    override func setConstraints() {
        super.setConstraints()
        setUI()
        
    }
    
    override func configure() {
        super.configure()
        getProfile()
    }
    
    private func getProfile() {
        APIRequest.shared.apiRequest(APIManager.getProfile, type: Getprofile.self) { result in
            switch result {
            case .success(let response):
                self.nickLabel.text = response.nick
                self.followerLabel.text = "\(response.followers.count) Followers · \(response.following.count) Following"
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setUI() {
        
        [topView, profileImageView, nickLabel, followerLabel, changeInfoButton].forEach {
            view.addSubview($0)
        }
        
        topView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(150)
        }
        
        profileImageView.snp.makeConstraints {
            $0.leading.equalTo(view).offset(20)
            $0.size.equalTo(topView.snp.height).multipliedBy(0.8)
            $0.centerY.equalTo(topView)
        }
        
        nickLabel.snp.makeConstraints {
            $0.top.equalTo(topView).offset(10)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(20)
            $0.trailing.equalTo(topView.snp.trailing).offset(-20)
        }
        
        followerLabel.snp.makeConstraints {
            $0.top.equalTo(nickLabel.snp.bottom).offset(10)
            $0.leading.equalTo(nickLabel)
        }
        
        changeInfoButton.snp.makeConstraints {
            $0.leading.equalTo(nickLabel)
            $0.bottom.equalTo(profileImageView)
        }
    }
    
    private let topView = {
        let view = UIView()
        return view
    }()
    
    private let profileImageView = {
        let view = UIImageView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 60
        view.clipsToBounds = true
        return view
    }()

    private let nickLabel = {
       let lb = UILabel()
        lb.font = .systemFont(ofSize: 25, weight: .bold)
        return lb
    }()
    
    private let followerLabel = {
        let lb = UILabel()
        return lb
    }()
    
    private lazy var changeInfoButton = {
        let bt = UIButton()
        bt.setTitle("  프로필 설정  ", for: .normal)
        bt.addTarget(self, action: #selector(changeInfo), for: .touchUpInside)
        bt.backgroundColor = Color.point.uiColor
        bt.layer.cornerRadius = 15
        bt.clipsToBounds = true
        return bt
    }()
    
    @objc
    func changeInfo() {
        
    }
}

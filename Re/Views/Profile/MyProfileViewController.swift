//
//  CommunityViewController.swift
//  Re
//
//  Created by 황인호 on 11/27/23.
//

import UIKit
import Kingfisher

class MyProfileViewController: BaseViewController {
    
    private let viewModel = MyProfileViewModel()
    
    override func setConstraints() {
        super.setConstraints()
        setUI()
        
    }
    
    override func configure() {
        super.configure()
        getProfile()
        lookMyPost()
    }
    
    private func getProfile() {
        APIRequest.shared.apiRequest(APIManager.getProfile, type: Getprofile.self) { result in
            switch result {
            case .success(let response):
                print(response)
                self.nickLabel.text = response.nick
                self.followerLabel.text = "\(response.followers.count) Followers · \(response.following.count) Following"
                guard let url = URL(string: APIKey.baseURL + (response.profile ?? "")) else { return }
                self.profileImageView.kf.setImage(with: url, options: [.requestModifier(KFModifier.shared.modifier)])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func lookMyPost() {
        viewModel.lookUpMyPost(id: KeyChain.shared.read(key: "id") ?? "") {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setUI() {
        
        [topView, profileImageView, nickLabel, followerLabel, changeInfoButton, lineView, tableView].forEach {
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
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(topView).inset(10)
            $0.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(10)
            $0.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
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
    
    private let lineView = {
        let view = UIView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var tableView = {
        let view = UITableView()
        view.register(MyPostTableViewCell.self, forCellReuseIdentifier: MyPostTableViewCell.identifier)
        view.rowHeight = 100
        view.separatorStyle = .singleLine
        view.delegate = self
        view.dataSource = self
        view.prefetchDataSource = self
        return view
    }()
    
    @objc
    func changeInfo() {
        let vc = ProfileModifyViewController()
        vc.nickname = nickLabel.text
        vc.profileImage = profileImageView.image
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
}

extension MyProfileViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if viewModel.getData.count - 1 == indexPath.row {
                lookMyPost()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPostTableViewCell.identifier, for: indexPath) as? MyPostTableViewCell else { return UITableViewCell() }
        
         let data = viewModel.getData
        
        let url = URL(string: APIKey.baseURL + (data[indexPath.row]?.image.first ?? "" + ".jpeg"))
        
        cell.titleTextView.text = data[indexPath.row]?.title
        cell.photoImageView.kf.setImage(with: url, options: [.requestModifier(KFModifier.shared.modifier)])
        
        guard let id = KeyChain.shared.read(key: "id") else { return UITableViewCell() }
        if data[indexPath.row]?.likes.contains(id) == true {
            cell.likeImage.image = UIImage(systemName: "heart.fill")
        }
        
        cell.timeLabel.text = data[indexPath.row]?.time.toSimpleFormattedString()
        cell.likeCountLabel.text = "\(data[indexPath.row]?.likes.count ?? 0)"
        cell.commentCount.text = "\(data[indexPath.row]?.comments.count ?? 0)"
        return cell
    }
}

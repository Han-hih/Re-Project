//
//  HomeViewController.swift
//  Re
//
//  Created by 황인호 on 11/26/23.
//

import UIKit

import Moya
import Kingfisher

final class HomeViewController: BaseViewController {
    
    private let viewModel = HomeViewModel()
    
    var getData: getTest?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APIRequest.shared.getPost { result in
            self.getData = result
            self.tableView.reloadData()
        }
    }
    override func configure() {
        super.configure()
        setUI()
    }
    
    override func setConstraints() {
        super.setConstraints()
        setNavigation()
        getPost()
        
//        print(getData.count)
        
    }
    
    private func getPost() {
        APIRequest.shared.getPost { result in
            self.getData = result
            self.tableView.reloadData()
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
    @objc func myButtonTapped() {
        let vc = AccountViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func loginButtonTapped() {
        let vc = LoginViewContoller()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setUI() {
        [tableView].forEach {
            view.addSubview($0)
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    private lazy var tableView = {
        let view = UITableView()
        view.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        view.rowHeight = 150
        view.separatorStyle = .singleLine
        view.backgroundColor = .red
        view.delegate = self
        view.dataSource = self
        return view
    }()
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = getData else { return 0 }
        return getData?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        guard let data = getData else { return UITableViewCell() }
        cell.titleTextView.text = data.data[indexPath.row].title
        cell.nickNameLabel.text = data.data[indexPath.row].creator.nick
        let modifier = AnyModifier { request in
            var request = request
            request.setValue(KeyChain.shared.read(key: "access") ?? "", forHTTPHeaderField: "Authorization")
            request.setValue(APIKey.apiKey, forHTTPHeaderField: "SesacKey")
            return request
        }
        let url = URL(string: APIKey.baseURL + (data.data[indexPath.row].image.first ?? "" + ".jpeg"))
        cell.photoImageView.kf.setImage(with: url, options: [.requestModifier(modifier)]) { result in
            switch result {
            case .success:
                print("성공")
            case .failure:
                print("실패")
            }
        }

        return cell
    }
}

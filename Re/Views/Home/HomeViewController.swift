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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataSetTableView()
    }
    
    override func configure() {
        super.configure()
        setUI()
    }
    
    override func setConstraints() {
        super.setConstraints()
        setNavigation()
        getDataSetTableView()
        
    }
    
    private func getDataSetTableView() {
        viewModel.getPost() {
            DispatchQueue.main.async {
                self.tableView.reloadData()
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
        view.delegate = self
        view.dataSource = self
        view.prefetchDataSource = self
        return view
    }()
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = viewModel.getData
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        
         let data = viewModel.getData
        
        let url = URL(string: APIKey.baseURL + (data[indexPath.row]?.image.first ?? "" + ".jpeg"))

        cell.titleTextView.text = data[indexPath.row]?.title
        cell.nickNameLabel.text = data[indexPath.row]?.creator.nick
        cell.photoImageView.kf.setImage(with: url, options: [.requestModifier(viewModel.modifier)])
        return cell
    }
}

extension HomeViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if viewModel.getData.count - 1 == indexPath.row {
                getDataSetTableView()
            }
        }
    }
}

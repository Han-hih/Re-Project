//
//  HomeDetailViewController.swift
//  Re
//
//  Created by 황인호 on 12/13/23.
//

import UIKit

final class HomeDetailViewController: BaseViewController {
    
    var detail = DetailInfo(like: [], image: [], comments: [], creator: Creator(id: "", nick: "", profile: ""), time: "", title: "", content: "")
    
    override func setConstraints() {
        super.setConstraints()
        setUI()
        
    }
    
    override func configure() {
        super.configure()
        
    }
    
    private func setUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [titleLabel, profileView, photoImageView, contentLabel].forEach {
            contentView.addSubview($0)
        }
        [authorLabel].forEach {
            profileView.addSubview($0)
        }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.snp.edges)
            $0.width.equalTo(scrollView.snp.width)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView)
            $0.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(20)
            $0.height.greaterThanOrEqualTo(view.snp.height).multipliedBy(0.1)
        }
        
        profileView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(titleLabel)
            $0.height.equalTo(view.snp.height).multipliedBy(0.1)
        }
        
        authorLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        photoImageView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(20)
            $0.top.equalTo(profileView.snp.bottom).offset(20)
            $0.height.equalTo(view.snp.height).multipliedBy(0.25)
        }
        
        contentLabel.snp.makeConstraints  {
            $0.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(20)
            $0.top.equalTo(photoImageView.snp.bottom).offset(10)
            $0.bottom.equalTo(contentView.snp.bottom)
        }
        
        
        
    }
    
    private let scrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = true
        scrollView.scrollsToTop = true
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private let contentView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.text = detail.title
        label.numberOfLines = 0
        return label
    }()
    
    private let profileView = {
        let view = UIView()
        return view
    }()
    
    private lazy var authorLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = detail.creator.nick
        return label
    }()
    
   private lazy var photoImageView = {
       let view = UIImageView()
       let url = URL(string: APIKey.baseURL + "\(detail.image.first ?? "")")
       print(url)
       view.kf.setImage(with: url, options: [.requestModifier(KFModifier.shared.modifier)])
       return view
   }()
    
    private lazy var contentLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = detail.content
        return label
    }()
    
    
    
    
    
}

//
//  HomeDetailViewController.swift
//  Re
//
//  Created by 황인호 on 12/13/23.
//

import UIKit

final class HomeDetailViewController: BaseViewController {
    
    var detail = DetailInfo(id: "", like: [], image: [], comments: [], creator: Creator(id: "", nick: "", profile: ""), time: "", title: "", content: "")
    
    override func setConstraints() {
        super.setConstraints()
        setUI()
        
    }
    
    override func configure() {
        super.configure()
       print(detail)
    }
    
    private func setUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [titleLabel, profileView, photoImageView, contentLabel].forEach {
            contentView.addSubview($0)
        }
        view.addSubview(floatingView)
        view.addSubview(stackView)
        [authorLabel].forEach {
            profileView.addSubview($0)
        }
        
        [heartButton, commentButton].forEach {
            stackView.addSubview($0)
        }
        stackView.isUserInteractionEnabled = true
        contentView.isUserInteractionEnabled = true
        floatingView.isUserInteractionEnabled = true
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
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(titleLabel)
            $0.height.equalTo(view.snp.height).multipliedBy(0.1)
        }
        
        authorLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        photoImageView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(20)
            $0.top.equalTo(profileView.snp.bottom).offset(10)
            $0.height.equalTo(view.snp.height).multipliedBy(0.25)
        }
        
        contentLabel.snp.makeConstraints  {
            $0.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(20)
            $0.top.equalTo(photoImageView.snp.bottom).offset(10)
            $0.bottom.equalTo(contentView.snp.bottom)
        }
        
        floatingView.snp.makeConstraints {
            $0.width.equalTo(150)
            $0.height.equalTo(40)
            $0.centerX.equalTo(view)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
       
        stackView.snp.makeConstraints {
            $0.center.equalTo(floatingView)
            $0.size.equalTo(200)
        }
        
        heartButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(floatingView.snp.leading).offset(20)
        }
        
        commentButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(floatingView.snp.centerX).offset(10)
        }
    }
    
    private lazy var scrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = true
        scrollView.scrollsToTop = true
        scrollView.isScrollEnabled = true
        scrollView.delegate = self
        
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
        label.font = .systemFont(ofSize: 20)
        label.text = detail.creator.nick
        return label
    }()
    
   private lazy var photoImageView = {
       let view = UIImageView()
       let url = URL(string: APIKey.baseURL + "\(detail.image.first ?? "")")
       view.kf.setImage(with: url, options: [.requestModifier(KFModifier.shared.modifier)])
       return view
   }()
    
    private lazy var contentLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = detail.content
        return label
    }()
    
    private let floatingView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowRadius = 4
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.7
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.masksToBounds = false
        return view
    }()
    
    private let stackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .bottom
        view.spacing = 20
        return view
    }()
    
    private let heartButton = {
        let view = UIImageView(image: UIImage(systemName: "heart"))
        view.tintColor = .red
        return view
    }()
    
    private lazy var commentButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "bubble"), for: .normal)
        bt.setTitle("  2", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        bt.tintColor = .blue
        bt.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        return bt
    }()
    
    @objc func commentButtonTapped() {
        let vc = CommentViewController()
        vc.contentID = detail.id
        self.present(vc, animated: true)
    }
    
}

extension HomeDetailViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard velocity.y != 0 else { return }
            if velocity.y < 0 {
                let height = self?.tabBarController?.tabBar.frame.height ?? 0.0
                self?.tabBarController?.tabBar.alpha = 1.0
                self?.tabBarController?.tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.maxY - height)
                self?.floatingView.isHidden = false
                self?.stackView.isHidden = false
                self?.navigationController?.navigationBar.isHidden = false
            } else {
                self?.tabBarController?.tabBar.alpha = 0.0
                self?.tabBarController?.tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.maxY)
                self?.floatingView.isHidden = true
                self?.stackView.isHidden = true
                self?.navigationController?.navigationBar.isHidden = true
            }
        }
    }
}

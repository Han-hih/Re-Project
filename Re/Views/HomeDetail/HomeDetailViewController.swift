//
//  HomeDetailViewController.swift
//  Re
//
//  Created by 황인호 on 12/13/23.
//

import UIKit

final class HomeDetailViewController: BaseViewController {
    
    var contentId: String? = nil
    
    private let viewModel = HomeDetailViewModel()
    
    private var likeArray: [String]? = []
    
    override func setConstraints() {
        super.setConstraints()
        setUI()
        
    }
    
    override func configure() {
        super.configure()
        setData()
    }
    
    private func setData() {
        guard let id = contentId else { return }
        viewModel.getOnePost(id: id) { result in
            print(result.image)
            self.titleLabel.text = result.title
            self.contentLabel.text = result.content
            self.contentLabel.hashString()
            self.authorImage.kf.setImage(with: URL(string: APIKey.baseURL + "\(result.creator.profile ?? "")"))
            self.authorLabel.text = result.creator.nick
            self.createdAtLabel.text = result.time.toFormattedString()
            let url = URL(string: APIKey.baseURL + "\(result.image.first ?? "")")
            
            self.photoImageView.kf.setImage(with: url, options: [.requestModifier(KFModifier.shared.modifier)])
            if self.photoImageView.image == nil {
                            self.photoImageView.isHidden = true
                        }
            self.heartButton.setTitle("  \(result.likes.count)", for: .normal)
            self.commentButton.setTitle("  \(result.comments.count)", for: .normal)
            
            self.likeArray = result.likes
        }
    }
    
    private func setUI() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [titleLabel, profileView, contentStackView, lineView].forEach {
            contentView.addSubview($0)
        }
        view.addSubview(floatingView)
        view.addSubview(stackView)
        [authorImage, authorLabel, createdAtLabel].forEach {
            profileView.addSubview($0)
        }
        
        [photoImageView, contentLabel].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        [heartButton, commentButton].forEach {
            stackView.addSubview($0)
        }
        stackView.isUserInteractionEnabled = true
        contentView.isUserInteractionEnabled = true
        floatingView.isUserInteractionEnabled = true
        contentStackView.isUserInteractionEnabled = true
        
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
            $0.height.greaterThanOrEqualTo(44)
        }
        
        profileView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(titleLabel)
            $0.height.equalTo(44)
        }
        
        authorImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.size.equalTo(44)
        }
        
        authorLabel.snp.makeConstraints {
            $0.top.equalTo(authorImage)
            $0.leading.equalTo(authorImage.snp.trailing).offset(8)
        }
        
        createdAtLabel.snp.makeConstraints {
            $0.top.equalTo(authorLabel.snp.bottom).offset(4)
            $0.leading.equalTo(authorLabel)
        }
        
        contentStackView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(20)
            $0.bottom.equalTo(contentView.snp.bottom)
        }
        
        
        photoImageView.snp.makeConstraints {
            $0.height.equalTo(view.snp.height).multipliedBy(0.25)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(authorImage.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
//        contentLabel.snp.makeConstraints  {
//            $0.height.equalTo(18)
//        }
        
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
        label.numberOfLines = 0
        return label
    }()
    
    private let profileView = {
        let view = UIView()
        return view
    }()
    
    private let authorImage = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 22
        return view
    }()
    
    private lazy var authorLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let createdAtLabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 14)
        return lb
    }()
    
    private let contentStackView = {
        let view = UIStackView()
        view.spacing = 10
        view.axis = .vertical
        view.distribution = .fill
        return view
    }()
    
    
    private lazy var photoImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var contentLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let lineView = {
        let view = UIView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        return view
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
    
    private lazy var heartButton = {
        let bt = UIButton()
        if let id = KeyChain.shared.read(key: "id") {
            bt.setImage(UIImage(systemName: likeArray?.contains(id) ?? false ? "heart.fill" : "heart"), for: .normal)
        }
        bt.setTitleColor(.black, for: .normal)
        bt.tintColor = .red
        bt.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return bt
    }()
    
    @objc func likeButtonTapped() {
        
        guard let id = viewModel.detail?.id else { return }
        viewModel.LikeButtonTapped(id: id) { result in
            DispatchQueue.main.async {
                let like = result.like_status
                self.heartButton.setImage(UIImage (systemName: like ? "heart.fill" : "heart"), for: .normal)
                
                if let id = KeyChain.shared.read(key: "id") {
                    if self.likeArray?.contains(id) == true {
                        self.heartButton.setTitle("  \((self.likeArray?.count ?? 0) - 1)", for: .normal)
                        self.likeArray?.removeAll { $0 == id }
                    } else {
                        self.heartButton.setTitle("  \((self.likeArray?.count ?? 0) + 1)", for: .normal)
                        self.likeArray?.append(id)
                    }
                }
            }
        }
    }
    
    private lazy var commentButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "bubble"), for: .normal)
        bt.setTitleColor(.black, for: .normal)
        bt.tintColor = .blue
        bt.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        return bt
    }()
    
    @objc func commentButtonTapped() {
        let vc = CommentViewController()
        let nav = UINavigationController(rootViewController: vc)
        vc.contentID = viewModel.detail?.id
        nav.modalPresentationStyle = .pageSheet
        if let sheet = nav.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 40
        }
        present(nav, animated: true)
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

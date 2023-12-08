//
//  AddViewController.swift
//  Re
//
//  Created by 황인호 on 11/27/23.
//

import UIKit

import SnapKit
import IQKeyboardManagerSwift
import PhotosUI


final class AddViewController: BaseViewController {
    
    private let viewModel = AddViewModel()
    
     var selections = [String: PHPickerResult]()
    
     var selectedAssetIdentifier = [String]()
    
    override func configure() {
        super.configure()
    }
    
    
    override func setConstraints() {
        super.setConstraints()
        setUI()
        setNavi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        setKeyboardManagerEnable(false)
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setKeyboardManagerEnable(true)
        IQKeyboardManager.shared.enableAutoToolbar = true
    }
    
    private func setNavi() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: postButton)
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .done, target: self, action: #selector(closeButtonTapped))
    }
    
    @objc func postButtonTapped() {
        APIRequest.shared.posting(param: Posting(title: titleTextField.text ?? "" , content: contentTextView.text, file: photoImageView.image?.jpegData(compressionQuality: 0.1), product_id: APIKey.product_id))
        }
        
        
    
    
    @objc func closeButtonTapped() {
        self.tabBarController?.selectedIndex = 0
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setUI() {
        view.addSubview(scrollView)
        view.addSubview(bottomView)
        scrollView.addSubview(contentView)
        [titleTextField, contentTextView, photoImageView].forEach {
            scrollView.addSubview($0)
        }
        [photoButton].forEach {
            bottomView.addSubview($0)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view)
            $0.bottom.equalTo(bottomView.snp.top).offset(-40)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.snp.edges)
            $0.width.equalTo(scrollView.snp.width)
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top)
            $0.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(20)
            $0.height.equalTo(70)
        }
        
        photoImageView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(20)
            $0.top.equalTo(titleTextField.snp.bottom).offset(10)
            $0.height.equalTo(view.snp.height).multipliedBy(0.3)
        }
        
        contentTextView.snp.makeConstraints  {
            $0.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(20)
            $0.top.equalTo(photoImageView.snp.bottom).offset(10)
            $0.bottom.equalTo(contentView.snp.bottom)
        }
        
        bottomView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        photoButton.snp.makeConstraints {
            $0.top.equalTo(bottomView.snp.top)
            $0.leading.equalTo(bottomView.snp.leading).offset(20)
            $0.height.equalTo(bottomView.snp.height)
            $0.width.equalTo(photoButton.snp.height)
        }
        
        postButton.snp.makeConstraints {
            $0.width.equalTo(50)
        }
    }
    
    private let scrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = true
        scrollView.scrollsToTop = true
        scrollView.isScrollEnabled = true
        scrollView.keyboardDismissMode = .onDrag
        return scrollView
    }()
    
    private let contentView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var postButton = {
        let bt = UIButton()
        bt.backgroundColor = Color.point.uiColor.withAlphaComponent(0.4)
        bt.setTitle("등록", for: .normal)
        bt.setTitleColor(Color.point.uiColor, for: .normal)
        bt.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        bt.layer.cornerRadius = 8
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(postButtonTapped), for: .touchUpInside)
        return bt
    }()
    
    private lazy var photoButton = {
        let bt = CustomButton()
        bt.setImage(UIImage(systemName: "camera"), for: .normal)
        bt.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        return bt
    }()
    
    private let hashButton = {
        let bt = CustomButton()
        bt.setImage(UIImage(systemName: "tag"), for: .normal)
        return bt
    }()
    
    private let titleTextField = {
        let tf = UITextField()
        tf.placeholder = " 제목"
        tf.font = .systemFont(ofSize: 30, weight: .semibold)
        return tf
    }()
    
     let photoImageView = {
        let view = UIImageView()
        return view
    }()
    
    
     let textViewPlaceholder = "내용을 입력하세요"
     lazy var contentTextView = {
        let tv = UITextView()
        tv.text = textViewPlaceholder
        tv.textColor = .lightGray
        tv.font = .systemFont(ofSize: 15)
        tv.showsVerticalScrollIndicator = false
        tv.isScrollEnabled = false
        tv.delegate = self
        return tv
    }()
    
    private let bottomView = {
        let view = UIView()
        return view
    }()
    
    @objc func photoButtonTapped() {
        presentPicker()
    }
    private func presentPicker() {
        //이미지 identifierfmf 사용하기위해 초기화를 shared
        var config = PHPickerConfiguration(photoLibrary: .shared())
        //라이브러리에서 보여줄 asset을 필터
        config.filter = PHPickerFilter.any(of: [.images])
        // 다중 선택 갯수 설정 0 = 무제한
        config.selectionLimit = 1
        // 선택 동작을 나타냄
        config.selection = .ordered
        //트랜스코딩방지
        config.preferredAssetRepresentationMode = .current
        // 선택했던 이미지 기억
        config.preselectedAssetIdentifiers = self.selectedAssetIdentifier
        
        let imagePicker = PHPickerViewController(configuration: config)
        imagePicker.delegate = self
        
        self.present(imagePicker, animated: true)
    }
    private func setKeyboardManagerEnable(_ isEnabled: Bool) {
        IQKeyboardManager.shared.enable = isEnabled
    }
}


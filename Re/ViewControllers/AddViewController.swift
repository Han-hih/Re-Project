//
//  AddViewController.swift
//  Re
//
//  Created by 황인호 on 11/27/23.
//

import UIKit

import SnapKit
import IQKeyboardManagerSwift


final class AddViewController: BaseViewController {
    
    var window: UIWindow?
    
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setKeyboardManagerEnable(true)
    }
    
    private func setNavi() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: postButton)
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .done, target: self, action: #selector(closeButtonTapped))
    }
    
    @objc func postButtonTapped() {
        print("포스트")
    }
    
    @objc func closeButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [titleTextField, contentTextView].forEach {
            scrollView.addSubview($0)
        }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view)
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
        
        contentTextView.snp.makeConstraints  {
            $0.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(20)
            $0.top.equalTo(titleTextField.snp.bottom).offset(10)
            $0.bottom.equalTo(contentView.snp.bottom)
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
            return scrollView
        }()
    
    private let contentView = {
        let view = UIView()
        
        return view
    }()
    
    private let postButton = {
        let bt = UIButton()
        bt.backgroundColor = Color.point.uiColor.withAlphaComponent(0.4)
        bt.setTitle("등록", for: .normal)
        bt.setTitleColor(Color.point.uiColor, for: .normal)
        bt.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        bt.layer.cornerRadius = 8
        bt.clipsToBounds = true
        
        return bt
    }()
    
    private let photoButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "camera.on.rectangle"), for: .normal)
        
        return bt
    }()
    
    private let hashButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "number.square"), for: .normal)
        
        return bt
    }()
    
    private let titleTextField = {
        let tf = UITextField()
        tf.placeholder = " 제목"
        tf.font = .systemFont(ofSize: 30, weight: .semibold)
        return tf
    }()
    
    
    private let textViewPlaceholder = "내용을 입력하세요"
    private lazy var contentTextView = {
        let tv = UITextView()
        tv.text = textViewPlaceholder
        tv.textColor = .lightGray
        tv.font = .systemFont(ofSize: 15)
        tv.showsVerticalScrollIndicator = false
        tv.isScrollEnabled = false
        tv.delegate = self
        return tv
    }()
    
    private func setKeyboardManagerEnable(_ isEnabled: Bool) {
        IQKeyboardManager.shared.enable = isEnabled
    }
}

extension AddViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceholder {
            textView.text = nil
            textView.textColor = .black
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceholder
            textView.textColor = .lightGray
        }
    }
}

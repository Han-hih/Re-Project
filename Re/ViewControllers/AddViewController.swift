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
    
    
    override func configure() {
        super.configure()
    }
    
    
    override func setConstraints() {
         super.setConstraints()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setKeyboardManagerEnable(false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setKeyboardManagerEnable(true)
    }
    
    private func setUI() {
        [postButton, titleTextField, contentTextView].forEach {
            view.addSubview($0)
        }
        postButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.width.equalTo(50)
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(postButton.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaInsets).inset(10)
            $0.height.equalTo(70)
        }
        
        contentTextView.snp.makeConstraints  {
            $0.horizontalEdges.equalTo(titleTextField.snp.horizontalEdges)
            $0.top.equalTo(titleTextField.snp.bottom).offset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
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
    
    private let titleTextField = {
        let tf = CustomTextField()
        tf.placeholder = "제목"
        tf.font = .systemFont(ofSize: 30, weight: .semibold)
        return tf
    }()
    
    
    private let textViewPlaceholder = "내용을 입력하세요"
    private lazy var contentTextView = {
        let tv = UITextView()
        tv.text = textViewPlaceholder
        tv.textColor = .lightGray
        tv.font = .systemFont(ofSize: 15)
        tv.showsVerticalScrollIndicator = true
        tv.scrollsToTop = true
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

//
//  CommentViewController.swift
//  Re
//
//  Created by 황인호 on 12/15/23.
//

import UIKit

class CommentViewController: BaseViewController {
    
    private let textViewPlaceholder = "댓글을 입력해 주세요."
    
    var contentID: String?
    
    private let viewModel = CommentViewModel()
    
    override func setConstraints() {
        super.setConstraints()
        setUI()
        setNav()
    }
    
    override func configure() {
        super.configure()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        getOnePost()
    }
    
    private func getOnePost() {
        guard let id = contentID else { return }
        viewModel.getOnePost(id: id) {
            self.navigationItem.title = "댓글(\(self.viewModel.postComments.count))"
            self.tableView.reloadData()
        }
    }
    
    private func getPostComment() {
        guard let id = contentID else { return }
        viewModel.postComment(id: id, comment: commentTextView.text) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }


    @objc func keyboardWillShow(_ notification: Notification) {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                postButton.isHidden = false
                view.layoutIfNeeded()
            }
        }

    @objc func keyboardWillHide(_ notification: Notification) {
        view.layoutIfNeeded()
    }
    
    private func setNav() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(closeButtonTap))
        self.navigationItem.rightBarButtonItem?.tintColor = Color.point.uiColor
    }
    
    @objc func closeButtonTap() {
        dismiss(animated: true)
    }
    
    private func setUI() {
        [tableView, bottomView, commentTextView, postButton].forEach {
            view.addSubview($0)
        }
        
        tableView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view)
            $0.height.equalTo(view).multipliedBy(0.88)
        }
        
        bottomView.snp.makeConstraints {
            $0.bottom.equalTo(view)
            $0.height.greaterThanOrEqualTo(100)
            $0.horizontalEdges.equalTo(view)
        }
        
        commentTextView.snp.makeConstraints {
            $0.bottom.equalTo(view)
            $0.leading.equalTo(view.snp.leading)
            $0.width.equalTo(view).multipliedBy(0.8)
            $0.height.greaterThanOrEqualTo(80)
        }
        
        postButton.snp.makeConstraints {
            $0.bottom.equalTo(view).offset(-40)
            $0.trailing.equalTo(view.snp.trailing).offset(-20)
            $0.width.equalTo(view).multipliedBy(0.1)
            $0.height.equalTo(postButton.snp.width)
        }
    }
    
    private lazy var tableView = {
        let view = UITableView()
        view.register(CommentTableViewCell.self, forCellReuseIdentifier:  CommentTableViewCell.identifier)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private let bottomView = {
        let view = UIView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    
    private lazy var commentTextView = {
        let view = UITextView()
        view.delegate = self
        view.text = textViewPlaceholder
        view.font = .systemFont(ofSize: 18)
        view.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return view
    }()
    
    private lazy var postButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "arrow.up"), for: .normal)
        bt.backgroundColor = Color.point.uiColor
        bt.isHidden = true
        bt.addTarget(self, action: #selector(self.postButtonTapped), for: .touchUpInside)
        bt.tintColor = .white
        return bt
    }()
    
    @objc func postButtonTapped() {
        DispatchQueue.global().sync {
            print("댓글보냄")
            getPostComment()
            viewModel.postComments.removeAll()
        }
        DispatchQueue.global().sync {
            print("불러오기")
            getOnePost()
        }
        
        commentTextView.text = ""
    }
}

extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.postComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as? CommentTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.personNickname.text = viewModel.postComments[indexPath.row].creator.nick
        cell.contentLabel.text = viewModel.postComments[indexPath.row].content
        return cell
    }
}

extension CommentViewController: UITextViewDelegate {
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
            postButton.isHidden = true
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        let maxHeight: CGFloat = 300
        
        if estimatedSize.height <= maxHeight {
            textView.isScrollEnabled = false
            textView.frame.size.height = estimatedSize.height
            bottomView.frame.size.height = estimatedSize.height
        } else if estimatedSize.height >= maxHeight {
            textView.isScrollEnabled = true
            textView.frame.size.height = maxHeight
            bottomView.frame.size.height = maxHeight + 10
        }
    }
}

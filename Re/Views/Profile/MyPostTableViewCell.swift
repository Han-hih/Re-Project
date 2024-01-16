//
//  MyPostTableViewCell.swift
//  Re
//
//  Created by 황인호 on 2/12/24.
//

import UIKit

class MyPostTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        likeImage.image = UIImage(systemName: "heart")
    }
    
    private func setUI() {
        [photoImageView, titleTextView, timeLabel, likeImage, likeCountLabel, commentCount, commentImage].forEach {
            contentView.addSubview($0)
        }
        
        photoImageView.snp.makeConstraints {
            $0.trailing.equalTo(contentView.snp.trailing).inset(20)
            $0.verticalEdges.equalToSuperview().inset(20)
            $0.width.equalTo(80)
        }
        
        titleTextView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(30)
            $0.trailing.equalTo(photoImageView.snp.leading).offset(-20)
        }
        
        timeLabel.snp.makeConstraints {
            $0.leading.equalTo(commentCount.snp.trailing).offset(10)
            $0.top.equalTo(likeImage.snp.top)
        }
        
        likeImage.snp.makeConstraints {
            $0.bottom.equalTo(photoImageView.snp.bottom)
            $0.leading.equalTo(titleTextView.snp.leading)
            $0.width.height.equalTo(20)
        }
        
        likeCountLabel.snp.makeConstraints {
            $0.leading.equalTo(likeImage.snp.trailing).offset(3)
            $0.top.equalTo(likeImage.snp.top)
        }
        
        commentImage.snp.makeConstraints {
            $0.leading.equalTo(likeCountLabel.snp.trailing).offset(10)
            $0.bottom.equalTo(likeImage.snp.bottom)
            $0.width.height.equalTo(20)
        }
        
        commentCount.snp.makeConstraints {
            $0.leading.equalTo(commentImage.snp.trailing).offset(3)
            $0.top.equalTo(likeImage.snp.top)
        }
        
    }
    
    let photoImageView = {
        let view = UIImageView()
        return view
    }()
    
    let titleTextView = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .natural
        label.numberOfLines = 3
        return label
    }()
    
    let timeLabel = {
        let label = UILabel()
        return label
    }()
    
    let likeCountLabel = {
        let label = UILabel()
        return label
    }()
    
    let likeImage = {
        let image = UIImageView()
        image.image = UIImage(systemName: "heart")
        image.tintColor = .red
        return image
    }()
    
    private let commentImage = {
        let image = UIImageView()
        image.image = UIImage(systemName: "text.bubble")
        return image
    }()
    
    let commentCount = {
        let label = UILabel()
        label.text = "3"
        return label
    }()
    
    
}

//
//  HomeTableViewCell.swift
//  Re
//
//  Created by 황인호 on 12/10/23.
//

import UIKit

import SnapKit

class HomeTableViewCell: UITableViewCell {
    
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
        [photoImageView, titleTextView, profileImage, nickNameLabel, timeLabel, likeImage, likeCountLabel, commentCount, commentImage].forEach {
            contentView.addSubview($0)
        }
        
        profileImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(10)
            $0.size.equalTo(30)
        }
        
        nickNameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImage.snp.trailing).offset(10)
            $0.centerY.equalTo(profileImage.snp.centerY)
            $0.height.equalTo(20)
        }
        
        photoImageView.snp.makeConstraints {
            $0.trailing.equalTo(contentView.snp.trailing).inset(20)
            $0.verticalEdges.equalToSuperview().inset(20)
            $0.width.equalTo(80)
        }
        
        titleTextView.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom)
            $0.leading.equalTo(profileImage.snp.leading)
            $0.height.equalTo(70)
            $0.trailing.equalTo(photoImageView.snp.leading).offset(-20)
            
        }
        
        likeImage.snp.makeConstraints {
            $0.bottom.equalTo(photoImageView.snp.bottom)
            $0.leading.equalTo(profileImage.snp.leading)
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
        
        timeLabel.snp.makeConstraints {
            $0.leading.equalTo(commentCount.snp.trailing).offset(10)
            $0.top.equalTo(likeImage.snp.top)
        }
        
    }
    
     let photoImageView = {
        let view = UIImageView()
        return view
    }()
    
    let titleTextView = {
        let label = UILabel()
        label.text = "성운설(星雲說)은 우주기원론 분야에서 태양계의 형성과 진화를 설명하는 데 있어 가장 널리 인정받는 가설이다."
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .natural
        label.numberOfLines = 3
        return label
    }()
    
    let nickNameLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.text = "Inho Hwang"
        label.textColor = .black
        return label
    }()
    
    let profileImage = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        return image
    }()
    
     let timeLabel = {
        let label = UILabel()
         label.textColor = .gray
        label.text = "15:02"
        return label
    }()
    
     let likeCountLabel = {
        let label = UILabel()
        label.text = "27"
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

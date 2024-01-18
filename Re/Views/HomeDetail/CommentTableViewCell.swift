//
//  CommentTableViewCell.swift
//  Re
//
//  Created by 황인호 on 12/17/23.
//

import UIKit
import SnapKit

class CommentTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUI() {
        [profileView, personNickname, timeLabel, modifyButton, contentLabel].forEach {
            contentView.addSubview($0)
        }
        
        profileView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        personNickname.snp.makeConstraints {
            $0.centerY.equalTo(profileView.snp.centerY).offset(-5)
            $0.leading.equalTo(profileView)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(personNickname.snp.bottom).offset(3)
            $0.leading.equalTo(profileView)
        }
        
        modifyButton.snp.makeConstraints {
            $0.centerY.equalTo(profileView)
            $0.trailing.equalTo(profileView.snp.trailing)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(5)
            $0.horizontalEdges.equalTo(profileView)
            $0.bottom.equalToSuperview().offset(-5)
        }
    }
    
   private let profileView = {
       let view = UIView()
       return view
   }()
    
    let personNickname = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 15)
        lb.text = "asd"
        return lb
    }()
    
    let timeLabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 12)
        lb.text = "3시간 전"
        return lb
    }()
   
    private let modifyButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        bt.tintColor = Color.point.uiColor
        return bt
    }()
    
    let contentLabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.font = .systemFont(ofSize: 14)
        lb.text = "단테와 수감자들이 간단한 자기소개[5]를 통해 안면을 튼 후, 림버스 컴퍼니 일행은 D사의 4구로 향한다. 도중에 길 안내를 맡은 유리를 비롯해 계약한 해결사들과 합류한 단테와 수감자들은 로보토미 지부 내부로 돌입한다. 로보토미 지부 내에서 단테와 수감자들은 그레고르와 유사한 시술을 받은 곤충 인간들을 마주하게 되고, 그들과 전투를 벌이면서 내부에 들어서지만 환상체와 마주하면서 계약 해결사인 아야가 사망하고, 홉킨스는 엔케팔린을 들고 도주하게 된다."
        return lb
    }()
    
    private let bottomView = {
        let view = UIView()
        return view
    }()
}

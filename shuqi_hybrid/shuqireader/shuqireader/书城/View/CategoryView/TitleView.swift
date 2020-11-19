//
//  TitleView.swift
//  shuqireader
//
//  Created by 李霆 on 2020/10/1.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

public enum LineHiddenType: String {
    case defaulttype = "显示间隔"
    case notype = "不显示间隔"
}

class TitleView: UIView {
    
    var type: LineHiddenType? {
         didSet {
            guard let type = type else {return}
            switch type {
            case .defaulttype:
                
                self.linView.isHidden = false
                
                self.linView.snp.remakeConstraints { (make) in
                    make.left.equalTo(0)
                    make.right.equalTo(0)
                    make.top.equalTo(0)
                    make.height.equalTo(10)
                }
                self.leftImageView.snp.remakeConstraints { (make) in
                    make.left.equalTo(10)
                    make.width.equalTo(12)
                    make.height.equalTo(32)
                    make.centerY.equalToSuperview().offset(8)
                }
                
                self.titleLable.snp.remakeConstraints { (make) in
                    make.left.equalTo(self.leftImageView.snp.right).offset(5)
                    make.width.equalTo(160)
                    make.height.equalTo(30)
                    make.centerY.equalTo(self.leftImageView.snp.centerY)
                }
                
                self.btn.snp.remakeConstraints { (make) in
                    make.right.equalToSuperview().offset(-15)
                    make.width.equalTo(160)
                    make.height.equalTo(30)
                    make.centerY.equalTo(self.leftImageView.snp.centerY)
                }
                break
            case .notype:
                
                self.linView.isHidden = true
                self.leftImageView.snp.remakeConstraints { (make) in
                    make.left.equalTo(10)
                    make.width.equalTo(12)
                    make.height.equalTo(32)
                    make.centerY.equalToSuperview()
                }
                
                self.titleLable.snp.remakeConstraints { (make) in
                    make.left.equalTo(self.leftImageView.snp.right).offset(5)
                    make.width.equalTo(160)
                    make.height.equalTo(30)
                    make.centerY.equalTo(self.leftImageView.snp.centerY)
                }
                
                self.btn.snp.remakeConstraints { (make) in
                    make.right.equalToSuperview().offset(-15)
                    make.width.equalTo(160)
                    make.height.equalTo(30)
                    make.centerY.equalTo(self.leftImageView.snp.centerY)
                }
                break
            }
        }
    }
    
    lazy var leftImageView: UIImageView = {
        let leftImageView = UIImageView()
        leftImageView.image = UIImage.init(named: "left_icon")
        return leftImageView
    }()
    
    lazy var titleLable: UILabel = {
        let titleLable = UILabel()
        titleLable.textColor = BlackTextColor
        titleLable.text = "大家都在看"
        titleLable.font = UIFont.boldSystemFont(ofSize: 16)
        return titleLable
    }()
    
    lazy var linView: UILabel = {
        let linView = UILabel()
        linView.backgroundColor = BackViewColor
        linView.frame = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 10)
       return linView
    }()
    
    lazy var btn: UIButton = {
        let btn = UIButton()
        btn .setTitleColor(BlackTextColor, for: .normal)
        btn .setTitle("查看更多 >", for: .normal)
        btn.titleLabel!.font = UIFont.boldSystemFont(ofSize: 14)
        btn.contentHorizontalAlignment = .right
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self .addSubview(self.leftImageView)
        self .addSubview(self.titleLable)
        self .addSubview(self.btn)
        self .addSubview(self.linView)
        
        self.linView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(10)
        }
        
        self.leftImageView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.width.equalTo(12)
            make.height.equalTo(32)
            make.centerY.equalToSuperview().offset(10)
        }
        
        self.titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(self.leftImageView.snp.right).offset(5)
            make.width.equalTo(160)
            make.height.equalTo(30)
            make.centerY.equalTo(self.leftImageView.snp.centerY)
        }
        
        self.btn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo(160)
            make.height.equalTo(30)
            make.centerY.equalTo(self.leftImageView.snp.centerY)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

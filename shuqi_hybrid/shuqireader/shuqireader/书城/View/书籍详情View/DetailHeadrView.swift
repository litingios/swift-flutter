//
//  DetailHeadrView.swift
//  shuqireader
//
//  Created by 李霆 on 2020/10/13.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class DetailHeadrView: UIView {

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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.linView)
        self.addSubview(self.titleLable)
        
        self.linView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(10)
        }
        
        self.titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.width.equalTo(160)
            make.top.equalTo(self.linView).offset(10)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

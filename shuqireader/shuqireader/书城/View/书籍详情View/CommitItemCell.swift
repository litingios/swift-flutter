//
//  CommitItemCell.swift
//  shuqireader
//
//  Created by 李霆 on 2020/10/12.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class CommitItemCell: UICollectionViewCell {
    @IBOutlet weak var commitIcon: UIImageView!
    @IBOutlet weak var nameLabe: UILabel!
    @IBOutlet weak var desLab: UILabel!
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var zanCountLab: UILabel!
    @IBOutlet weak var commitCountLab: UILabel!
    
    var model: CommentModel?{
        didSet{
            guard let model = model else {return}
            self.nameLabe.text = model.nickName
            self.commitIcon.kf.setImage(with: URL(string:"https://img-tailor.11222.cn/bcv/big/202004081430288485.jpg" ))
            self.desLab.text = model.text
            self.zanCountLab.text = model.zanNum
            self.commitCountLab.text = model.replyNum
            self.timeLable.text = timeIntervalChangeToTimeStr(timeInterval: model.pubTime,"yyyy-MM-dd")
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        commitIcon.contentMode = UIView.ContentMode.scaleToFill
        setRounded(view: commitIcon, 1, UIColor.clear, 15)
        
        nameLabe.textColor = UIColor.init(r: 193, g: 191, b: 204)
        zanCountLab.textColor = UIColor.init(r: 193, g: 191, b: 204)
        commitCountLab.textColor = UIColor.init(r: 193, g: 191, b: 204)
        timeLable.textColor = UIColor.init(r: 193, g: 191, b: 204)
        desLab.textColor = UIColor(r: 50, g: 50, b: 50);
        
    }

    @IBAction func zanBtnCiled(_ sender: Any) {
        
    }
    
    @IBAction func commitBtnCiled(_ sender: Any) {
        
    }
    
    
}

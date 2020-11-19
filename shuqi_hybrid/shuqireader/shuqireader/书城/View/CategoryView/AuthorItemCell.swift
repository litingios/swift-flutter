//
//  AuthorItemCell.swift
//  shuqireader
//
//  Created by 李霆 on 2020/10/10.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class AuthorItemCell: UICollectionViewCell {

    @IBOutlet weak var iconVIew: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var bookLab: UILabel!
    @IBOutlet weak var desLab: UILabel!
    @IBOutlet weak var nameLab: UILabel!
    
    var model: AuthorInfoModle? {
        didSet {
            guard let model = model else {return}
            
            self.iconVIew.kf.setImage(with: URL(string: "https://img-tailor.11222.cn/bcv/big/1106057986654.jpg" ))
            self.nameLab.text = model.authorName
            self.desLab.text = model.authorDesc
            self.bookLab.text = "代表作: 《" + (model.bookList?[0].bookName)! + "》《" + (model.bookList?[1].bookName)! + "》《" + (model.bookList?[2].bookName)! + "》"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.backView.backgroundColor = UIColor.init(r: 247, g: 247, b: 247)
        self.backView.contentMode = UIView.ContentMode.scaleToFill
        self.backView.clipsToBounds = true
        self.backView.layer.borderWidth = 1
        self.backView.layer.borderColor = UIColor.init(r: 233, g: 233, b: 235).cgColor
        self.backView.layer.cornerRadius = 6
        self.backView.layer.masksToBounds = true

        self.iconVIew.contentMode = UIView.ContentMode.scaleToFill
        self.iconVIew.clipsToBounds = true
        self.iconVIew.layer.borderWidth = 1
        self.iconVIew.layer.borderColor = UIColor.init(r: 233, g: 233, b: 235).cgColor
        self.iconVIew.layer.cornerRadius = 25
        self.iconVIew.layer.masksToBounds = true
        
        self.iconVIew.backgroundColor = MainColor
        
        self.desLab.textColor = UIColor(r: 40, g: 43, b: 53);
        self.bookLab.textColor = UIColor(r: 40, g: 43, b: 53);
    }

}

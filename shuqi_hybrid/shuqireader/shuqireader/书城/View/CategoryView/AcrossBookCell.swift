//
//  AcrossBookCell.swift
//  shuqireader
//
//  Created by 李霆 on 2020/9/29.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class AcrossBookCell: UICollectionViewCell {

    @IBOutlet weak var line01: UILabel!
    @IBOutlet weak var bookView: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var desLable: UILabel!
    @IBOutlet weak var authorLable: UILabel!
    @IBOutlet weak var statesLable: UILabel!
    @IBOutlet weak var statesLable02: UILabel!
    
    var model: BookItemModel? {
        didSet {
            guard let model = model else {return}
            self.bookView.kf.setImage(with: URL(string:model.imgUrl! ))
            self.nameLable.text = model.bookName
            self.desLable.text = model.desc
            self.authorLable.text = model.authorName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.nameLable.textColor = UIColor(r: 40, g: 43, b: 53);
        self.desLable.textColor = QianTextColor
        self.authorLable.textColor = QianTextColor

        self.line01.backgroundColor = LineColor
        
        self.bookView.contentMode = UIView.ContentMode.scaleToFill
        self.bookView.clipsToBounds = true
        self.bookView.layer.borderWidth = 1
        self.bookView.layer.borderColor = UIColor.clear.cgColor
        self.bookView.layer.cornerRadius = 6
        self.bookView.layer.masksToBounds = true
        
        self.statesLable.clipsToBounds = true
        self.statesLable.layer.borderWidth = 0.6
        self.statesLable.layer.borderColor = MainColor.cgColor
        self.statesLable.layer.cornerRadius = 2
        self.statesLable.layer.masksToBounds = true
        self.statesLable.textColor = MainColor
        
        self.statesLable02.clipsToBounds = true
        self.statesLable02.layer.borderWidth = 0.6
        self.statesLable02.layer.borderColor = QianTextColor.cgColor
        self.statesLable02.layer.cornerRadius = 2
        self.statesLable02.layer.masksToBounds = true
        self.statesLable02.textColor = UIColor.darkGray
    }

}

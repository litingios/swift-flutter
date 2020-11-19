//
//  BangCell.swift
//  shuqireader
//
//  Created by 李霆 on 2020/10/9.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class BangCell: UICollectionViewCell {
    @IBOutlet weak var bookView: UIImageView!
    @IBOutlet weak var bookNameLab: UILabel!
    @IBOutlet weak var countLab: UILabel!
    
    var model: BookItemModel? {
        didSet {
            guard let model = model else {return}
            self.bookView.kf.setImage(with: URL(string:model.imgUrl! ))
            self.bookNameLab.text = model.bookName
            self.countLab.text = String(format: "%.1f", CGFloat((model.numClick! as NSString).floatValue)/10000) + " 万人在读"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.bookView.contentMode = UIView.ContentMode.scaleAspectFit
        self.bookView.clipsToBounds = true
        self.bookView.layer.borderWidth = 1
        self.bookView.layer.borderColor = UIColor.clear.cgColor
        self.bookView.layer.cornerRadius = 6
        self.bookView.layer.masksToBounds = true
    }

}

//
//  VerticalBookCell.swift
//  shuqireader
//
//  Created by 李霆 on 2020/9/29.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class VerticalBookCell: UICollectionViewCell {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var desLable: UILabel!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var listionView: UIImageView!
    
    var model: BookItemModel? {
        didSet {
            guard let model = model else {return}
            self.bookImageView.kf.setImage(with: URL(string:model.imgUrl! ))
            self.desLable.text = model.bookName
            self.nameLable.text = model.authorName
        }
    }
    
    var listenHidden: Bool? {
        didSet{
            guard let listenHidden = listenHidden else {return}
            self.listionView.isHidden = listenHidden
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.desLable.textColor = UIColor(r: 40, g: 43, b: 53);
        self.nameLable.textColor = QianTextColor
        
        self.bookImageView.contentMode = UIView.ContentMode.scaleToFill
        self.bookImageView.clipsToBounds = true
        self.bookImageView.layer.borderWidth = 1
        self.bookImageView.layer.borderColor = UIColor.clear.cgColor
        self.bookImageView.layer.cornerRadius = 6
        self.bookImageView.layer.masksToBounds = true
        self.listionView.isHidden = true
    }

}

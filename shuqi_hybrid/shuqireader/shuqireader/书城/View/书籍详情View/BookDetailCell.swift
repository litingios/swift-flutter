//
//  BookDetailCell.swift
//  shuqireader
//
//  Created by 李霆 on 2020/10/12.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

public protocol BookDetailCellDelegate: NSObjectProtocol{
    // 点击目录
    func catalogueMethod()
    
}

class BookDetailCell: UICollectionViewCell {
    weak var delegate: BookDetailCellDelegate?
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookNameLab: UILabel!
    @IBOutlet weak var authorLab: UILabel!
    @IBOutlet weak var categoryLab: UILabel!
    @IBOutlet weak var pingFenLab: UILabel!
    @IBOutlet weak var pingNumberLab: UILabel!
    @IBOutlet weak var readerLab: UILabel!
    @IBOutlet weak var peopleLab: UILabel!
    @IBOutlet weak var ziSizeLab: UILabel!
    @IBOutlet weak var recomendView: UIView!
    @IBOutlet weak var recomondLab: UILabel!
    @IBOutlet weak var desLab: UILabel!
    @IBOutlet weak var zhangNumLabel: UILabel!
    @IBOutlet weak var statesLab: UILabel!
    @IBOutlet weak var lineLable: UILabel!
    @IBOutlet weak var CatalogueBtn: UIButton!
    
    var model: DetailModel? {
        didSet {
            guard let model = model else {return}
            self.bookImageView.kf.setImage(with: URL(string:model.imgUrl! ))
            self.bookNameLab.text = model.bookName
            self.authorLab.text = model.authorName! + ">"
            self.categoryLab.text = (model.category ?? "言情") + " | " + model.displayState!
            self.pingFenLab.text = model.score
            self.pingNumberLab.text = model.people! + ">"
            
            self.readerLab.text = String(format: "%.1f", CGFloat((model.readingNum! as NSString).floatValue)/10000)
            self.peopleLab.text = String(format: "%.1f", CGFloat((model.popularity! as NSString).floatValue)/10000)
            
            self.ziSizeLab.text = model.ziNum
            self.recomondLab.text = model.recIntro
            self.desLab.text = model.desc
            
            self.zhangNumLabel.text = model.chapterTitle
            self.statesLab.text = model.chapterState
            
        }
    } 
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
        self.bookImageView.contentMode = UIView.ContentMode.scaleToFill
        self.bookImageView.clipsToBounds = true
        self.bookImageView.layer.borderWidth = 1
        self.bookImageView.layer.borderColor = UIColor.clear.cgColor
        self.bookImageView.layer.cornerRadius = 6
        self.bookImageView.layer.masksToBounds = true
        
        self.authorLab.textColor = UIColor(r: 50, g: 50, b: 50);
        self.categoryLab.textColor = QianTextColor
        
        
        self.recomendView.contentMode = UIView.ContentMode.scaleToFill
        self.recomendView.clipsToBounds = true
        self.recomendView.layer.borderWidth = 1
        self.recomendView.layer.borderColor = UIColor.init(r: 241, g: 238, b: 235).cgColor
        self.recomendView.layer.cornerRadius = 6
        self.recomendView.layer.masksToBounds = true
        
        self.desLab.textColor = UIColor(r: 50, g: 50, b: 50)
        self.zhangNumLabel.textColor = QianTextColor
        self.statesLab.textColor = QianTextColor
        self.lineLable.backgroundColor = BackViewColor
        
    }

    @IBAction func CatalogueBtnCield(_ sender: Any) {
        delegate?.catalogueMethod()
    }
}

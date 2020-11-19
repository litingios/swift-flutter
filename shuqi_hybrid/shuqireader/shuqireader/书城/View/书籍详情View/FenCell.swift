//
//  FenCell.swift
//  shuqireader
//
//  Created by 李霆 on 2020/10/12.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class FenCell: UICollectionViewCell {

    @IBOutlet weak var peopleView01: UIImageView!
    @IBOutlet weak var peopleView02: UIImageView!
    @IBOutlet weak var peopleView03: UIImageView!
    @IBOutlet weak var shangView: UIView!
    @IBOutlet weak var shangCountLab: UILabel!
    @IBOutlet weak var touView: UIView!
    @IBOutlet weak var touCountLab: UILabel!
    
    var model: DetailModel?{
        didSet{
            guard let model = model else {return}
            self.shangCountLab.text = model.rewardNum
            self.touCountLab.text = model.recommendTicketNum
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.peopleView01.contentMode = UIView.ContentMode.scaleToFill
        self.peopleView01.clipsToBounds = true
        self.peopleView01.layer.borderWidth = 1
        self.peopleView01.layer.borderColor = UIColor.white.cgColor
        self.peopleView01.layer.cornerRadius = 15
        self.peopleView01.layer.masksToBounds = true
        
        self.peopleView02.contentMode = UIView.ContentMode.scaleToFill
        self.peopleView02.clipsToBounds = true
        self.peopleView02.layer.borderWidth = 1
        self.peopleView02.layer.borderColor = UIColor.white.cgColor
        self.peopleView02.layer.cornerRadius = 15
        self.peopleView02.layer.masksToBounds = true
        
        self.peopleView03.contentMode = UIView.ContentMode.scaleToFill
        self.peopleView03.clipsToBounds = true
        self.peopleView03.layer.borderWidth = 1
        self.peopleView03.layer.borderColor = UIColor.white.cgColor
        self.peopleView03.layer.cornerRadius = 15
        self.peopleView03.layer.masksToBounds = true
        
        self.shangView.contentMode = UIView.ContentMode.scaleToFill
        self.shangView.clipsToBounds = true
        self.shangView.layer.borderWidth = 1
        self.shangView.layer.borderColor = UIColor.clear.cgColor
        self.shangView.layer.cornerRadius = 6
        self.shangView.layer.masksToBounds = true
        
        self.touView.contentMode = UIView.ContentMode.scaleToFill
        self.touView.clipsToBounds = true
        self.touView.layer.borderWidth = 1
        self.touView.layer.borderColor = UIColor.clear.cgColor
        self.touView.layer.cornerRadius = 6
        self.touView.layer.masksToBounds = true
        
    }

}

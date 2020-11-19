//
//  BookInfoCell.swift
//  shuqireader
//
//  Created by 李霆 on 2020/10/12.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class BookInfoCell: UICollectionViewCell {
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var desLable: UILabel!
    
    var model: DetailModel?{
        didSet{
            guard let model = model else {return}
            self.titleLable.text = model.copyRightSource
            self.desLable.text = model.copyRightClaim
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.desLable.textColor = UIColor(r: 50, g: 50, b: 50);
        self.titleLable.textColor = UIColor(r: 50, g: 50, b: 50);
        
    }

}

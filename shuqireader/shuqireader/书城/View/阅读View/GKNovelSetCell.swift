//
//  GKNovelSetCell.swift
//  shuqireader
//
//  Created by 李霆 on 2020/10/12.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class GKNovelSetCell: UICollectionViewCell {



    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var imageV: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imageV.layer.masksToBounds = true;
        self.imageV.layer.cornerRadius = 25;
    }
}

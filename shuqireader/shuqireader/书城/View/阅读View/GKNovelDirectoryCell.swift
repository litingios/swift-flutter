//
//  GKNovelDirectoryCell.swift
//  shuqireader
//
//  Created by 李霆 on 2020/10/12.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class GKNovelDirectoryCell: UITableViewCell {
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var imageLock: UIImageView!
    
    var _select : Bool = false;
    var select : Bool{
        set{
            _select = newValue;
            self.titleLab.textColor = _select ? AppColor : Appx333333;
        }get{
            return _select;
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  CatalogueCell.swift
//  shuqireader
//
//  Created by 李霆 on 2020/10/20.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class CatalogueCell: UITableViewCell {

    var model: CatalogueModle? {
        didSet{
            guard let model = model else {return}
            self.nameLab.text = model.title
        }
    }
    
    
    @IBOutlet weak var nameLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

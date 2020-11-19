//
//  GKNovelTopView.swift
//  shuqireader
//
//  Created by 李霆 on 2020/10/12.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
@objc protocol GKTopDelegate :NSObjectProtocol{
    @objc optional func topView(topView : GKNovelTopView,back : Bool)
    @objc optional func topView(topView : GKNovelTopView,fav  : Bool)
}
class GKNovelTopView: UIView {

    weak var delegate : GKTopDelegate?
    @IBOutlet weak var backBtn: UIButton!

    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var titleLab: UILabel!
    @IBAction func backAction(_ sender: UIButton) {
        
        if let delegate = self.delegate {
            delegate.topView?(topView: self, back:true)
        }
    }
    
    @IBAction func favAction(_ sender: UIButton) {
        self.favBtn.isSelected = !self.favBtn.isSelected
        if let delegate = self.delegate {
            delegate.topView?(topView: self, fav: sender.isSelected)
        }
    }
}

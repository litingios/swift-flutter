//
//  GKNovelTabView.swift
//  shuqireader
//
//  Created by 李霆 on 2020/10/12.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
@objc protocol GKBottomDelegate :NSObjectProtocol{
    @objc optional func bottomView(bottomView :GKNovelTabView,last   :Bool)
    @objc optional func bottomView(bottomView :GKNovelTabView,set    :Bool)
    @objc optional func bottomView(bottomView :GKNovelTabView,day    :Bool)
    @objc optional func bottomView(bottomView :GKNovelTabView,mulu   :Bool)
    @objc optional func bottomView(bottomView :GKNovelTabView,slider :Int)
}
class GKNovelTabView: UIView {
    weak var delegate :GKBottomDelegate?
    @IBOutlet weak var muluBtn: UIButton!
    @IBOutlet weak var dayBtn: UIButton!
    @IBOutlet weak var setBtn: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var lastBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var bottomHeight: NSLayoutConstraint!
    override func awakeFromNib() {
        self.bottomHeight.constant = SAFEAREA_BOTTOM + 5;
        self.slider.setThumbImage(UIImage.init(named: "icon_slider"), for: .normal)
        
    }
    @IBAction func lastAction(_ sender: UIButton) {
        if let delegate = self.delegate {
            delegate.bottomView?(bottomView: self, last: true)
        }
    }
    @IBAction func nextAction(_ sender: UIButton) {
        if let delegate = self.delegate {
            delegate.bottomView?(bottomView: self, last: false)
        }
    }
    @IBAction func muluAction(_ sender: UIButton) {
        if let delegate = self.delegate {
             delegate.bottomView?(bottomView: self, mulu: true)
         }
    }
    
    @IBAction func dayAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if let delegate = self.delegate {
            delegate.bottomView?(bottomView: self, day: sender.isSelected)
        }
    }
    @IBAction func setAction(_ sender: UIButton) {
        if let delegate = self.delegate {
            delegate.bottomView?(bottomView: self, set: true)
        }
    }
    @IBAction func sliderAction(_ sender: UISlider) {
        if let delegate = self.delegate {
            delegate.bottomView?(bottomView: self, slider: Int(sender.value))
        }
    }
}

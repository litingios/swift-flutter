//
//  GKNovelContentView.swift
//  shuqireader
//
//  Created by 李霆 on 2020/10/12.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
private let tap_set_heigt     = CGFloat(200)
private let tap_bottom_height = CGFloat(90 + SAFEAREA_BOTTOM)
class GKNovelTapView: UIView {

    lazy var topView : GKNovelTopView = {
        let top  = GKNovelTopView.instanceView()
        return top
    }()
    
    lazy var bottomS : UIView = {
        return UIView.init()
    }()
    
    lazy var bottomView : GKNovelTabView = {
        let top = GKNovelTabView.instanceView()
        top.setBtn.addTarget(self, action: #selector(setAction), for: .touchUpInside)
        top.muluBtn.addTarget(self, action:#selector(showMuluView), for: .touchUpInside)
        return top
    }()
    lazy var setView : GKNovelSetView = {
        let top = GKNovelSetView.instanceView()
        return top
    }()
    lazy var directoryView: GKNovelDirectoryView = {
        let view : GKNovelDirectoryView = GKNovelDirectoryView.instanceView();
        view.isHidden = true;
        return view;
    }()
    lazy var tapView: UIView = {
        return UIView.init()
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
    }
    public func showTapAction(){
        self.isHidden = false
        self.loadShowTop()
    }
    @objc func tapAction(){
        if self.directoryView.isHidden == false {
            hiddenMuluView()
        }
        else if self.setView.isHidden {
            loadHiddenTop(needHidden: true)
        }else{
            loadHiddenBottom()
        }
    }
    public var content :GKNovelContent?{
        didSet{
            guard let content = content else { return }
            self.topView.titleLab.text = content.title
            self.bottomView.slider.maximumValue = Float(content.pageCount-1)
            self.bottomView.slider.minimumValue = 0
            self.bottomView.slider.value = Float(content.pageIndex)
        }
    }
    
    private func loadUI(){
        self.isHidden = true
        self.backgroundColor = UIColor.clear
        self.topView.isHidden = true
        self.bottomS.isHidden = true
        self.bottomView.isHidden = true
        self.setView.isHidden = true
        self.tapView.isHidden = true
        addSubview(self.topView)
        addSubview(self.bottomS)
        self.bottomS.addSubview(self.setView)
        self.bottomS.addSubview(self.bottomView)
        addSubview(self.tapView)
        
        self.topView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(-navigationBarHeight)
            make.height.equalTo(navigationBarHeight)
        }
        self.bottomS.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(tap_bottom_height)
            make.bottom.equalToSuperview().offset(tap_bottom_height)
        }
        self.bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(tap_bottom_height)
        }
        self.tapView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.topView.snp.bottom)
            make.bottom.equalTo(self.bottomS.snp.top)
        }
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction))
        self.tapView.addGestureRecognizer(tap)
        self.setView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(tap_set_heigt)
            make.top.equalTo(self.bottom)
        }
        
        self.addSubview(self.directoryView)
        self.directoryView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH/5*4)
            make.left.equalToSuperview().offset(-SCREEN_WIDTH/5*4)
        }
    }
    private func loadShowTop(){
        self.bottomS.isHidden = false
        self.bottomView.isHidden = false
        self.topView.isHidden = false
        self.tapView.isHidden = false
        self.topView.snp.remakeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(navigationBarHeight)
        }
        self.bottomS.snp.remakeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(tap_bottom_height)
        }
        self.tapView.snp.remakeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.topView.snp.bottom)
            make.bottom.equalTo(self.bottomS.snp.top)
        }
        UIView.animate(withDuration: 0.4, animations: {
            self.layoutIfNeeded()
        }) { (finish) in
            let vc = UIViewController.rootTopPresentedController()
            vc.setNeedsStatusBarAppearanceUpdate()
        }
    }
    private func loadHiddenTop(needHidden : Bool){
        self.topView.snp.remakeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(navigationBarHeight)
            make.top.equalTo(-navigationBarHeight);
        }
        self.bottomS.snp.remakeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(tap_bottom_height)
            make.bottom.equalTo(tap_bottom_height);
        }
        UIView.animate(withDuration: 0.4, animations: {
            self.layoutIfNeeded()
        }) { (finish) in
            self.bottomS.isHidden = finish
            self.topView.isHidden = finish
            self.setView.isHidden = finish
            self.isHidden = needHidden
            let vc = UIViewController.rootTopPresentedController()
            vc.setNeedsStatusBarAppearanceUpdate()
        }
    }
    private func loadShowSet(){
        self.setView.isHidden = false
        self.bottomS.snp.remakeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(tap_set_heigt + tap_bottom_height)
        }
        self.setView.snp.remakeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(tap_set_heigt)
            make.top.equalTo(0)
        }
        UIView.animate(withDuration: 0.4) {
            self.layoutIfNeeded()
        }
    }
    private func loadHiddenSet(){
        self.setView.isHidden = false
        self.bottomS.snp.remakeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(tap_bottom_height)
        }
        self.setView.snp.remakeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(tap_set_heigt)
            make.bottom.equalTo(self.bottomView.snp.top).offset(tap_set_heigt)
        }
        UIView.animate(withDuration: 0.4, animations: {
            self.layoutIfNeeded()
        }) { (finish) in
            self.setView.isHidden = finish
        }
    }
    private func loadHiddenBottom(){
        self.topView.snp.remakeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(navigationBarHeight)
            make.top.equalTo(-navigationBarHeight);
        }
        self.bottomS.snp.remakeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(tap_bottom_height + tap_set_heigt)
            make.bottom.equalTo(tap_bottom_height + tap_set_heigt);
        }
        UIView.animate(withDuration: 0.4, animations: {
            self.layoutIfNeeded()
        }) { (finish) in
            self.bottomS.isHidden = finish
            self.topView.isHidden = finish
            self.setView.isHidden = finish
            self.isHidden = finish
            let vc = UIViewController.rootTopPresentedController()
            vc.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    @objc private func showMuluView(){
        self.directoryView.isHidden = false
        self.loadHiddenTop(needHidden: false)
        self.directoryView.snp.remakeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH/5*4)
            make.left.equalToSuperview().offset(0)
        }
        self.tapView.snp.remakeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(self.directoryView.snp.right)
        }
        UIView.animate(withDuration: 0.4) {
            self.layoutIfNeeded()
        }
    }
    private func hiddenMuluView(){

        self.directoryView.snp.remakeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH/5*4)
            make.left.equalToSuperview().offset(-SCREEN_WIDTH/5*4)
        }
        UIView.animate(withDuration: 0.4, animations: {
            self.layoutIfNeeded()
        }) { (finish) in
            self.isHidden = finish
            self.directoryView.isHidden = finish
            let vc = UIViewController.rootTopPresentedController()
            vc.setNeedsStatusBarAppearanceUpdate()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func setAction(){
        if self.setView.isHidden {
            loadShowSet()
        }else{
            loadHiddenSet()
        }
    }

}

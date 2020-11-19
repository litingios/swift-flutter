//
//  CommonHeaderView.swift
//  shuqireader
//
//  Created by 李霆 on 2020/9/29.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import SwiftMessages
import FSPagerView

public protocol CommonHeaderViewDelegate: NSObjectProtocol{
    func headerViewSelect()
}

public enum ESRefreshExampleType: String {
    case defaulttype = "推荐"
    case boytype = "男生"
    case girltype = "女生"
    case optimization = "优选"
    case firstIssue = "首发"
    case original = "全民原创"
}

class CommonHeaderView: UICollectionViewCell {
    weak var delegate: CommonHeaderViewDelegate?

    var type: ESRefreshExampleType? {
         didSet {
            guard let type = type else {return}
            switch type {
            case .defaulttype:
                self.btnView.isHidden = true
                self.leftView.isHidden = false
                self.titleLable.isHidden = false
                break
            case .boytype:
                self.leftView.isHidden = true
                self.titleLable.isHidden = true
                self.btnView.isHidden = false
                
                break
            case .girltype:
                break
            case .optimization:
                break
            case .firstIssue:
                break
            case .original:
                self.btnView.isHidden = true
                self.leftView.isHidden = true
                self.titleLable.isHidden = true
                break
            }
        }
    }
    
    var titleStr: String? {
        didSet{
            guard let titleStr = titleStr else { return }
            self.titleLable.text = titleStr
        }
    }
    
    var slidesList: [SlidesModel]? {
        didSet{
            guard slidesList != nil else {return}
            
            self.pagerControl.numberOfPages = self.slidesList!.count
            self.pagerView.reloadData()
        }
    }

    var classifyList: [ClassifyModel]? {
        didSet{
            guard classifyList != nil else {return}
            for i in 0...3 {
                let model: ClassifyModel = classifyList![i]
                let btn: UIButton = self.btnView.viewWithTag(100+i) as! UIButton
                btn.kf.setImage(with: URL(string: model.icon!), for: .normal)
                let lable: UILabel = self.btnView.viewWithTag(200+i) as! UILabel
                lable.text = model.title
            }
        }
    }
    
    
    // 懒加载滚动图片浏览器
    private lazy var pagerView : FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.automaticSlidingInterval =  3
        pagerView.isInfinite = !pagerView.isInfinite
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "ShopBannerCell")
        return pagerView
    }()
    
    // 懒加载滚动图片浏下标
    lazy var pagerControl:FSPageControl = {
        let pageControl = FSPageControl()
        //设置下标位置
        pageControl.contentHorizontalAlignment = .center
        //设置下标指示器边框颜色（选中状态和普通状态）
        pageControl.setStrokeColor(.white, for: .normal)
        pageControl.setStrokeColor(.lightGray, for: .selected)
        //设置下标指示器颜色（选中状态和普通状态）
        pageControl.setFillColor(.white, for: .normal)
        pageControl.setFillColor(.lightGray, for: .selected)
        pageControl.setPath(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 6, height: 6)), for: .normal)
        pageControl.setPath(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 6, height: 6)), for: .selected)
        return pageControl
    }()

    lazy var leftView: UIImageView = {
        let leftView = UIImageView()
        leftView.image = UIImage.init(named: "left_icon")
        return leftView
    }()
    
    lazy var titleLable: UILabel = {
        let titleLable = UILabel()
        titleLable.textColor = BlackTextColor
        titleLable.text = "大家都在看"
        titleLable.font = UIFont.boldSystemFont(ofSize: 16)
        return titleLable
    }()
    
    var btnView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.pagerView)
        self.addSubview(self.pagerControl)
        self.addSubview(self.leftView)
        self.addSubview(self.titleLable)
        
        creatBtnView()
        
        self.pagerView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(0)
            make.height.equalTo(140)
        }
        self.pagerControl.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.bottom.equalTo(pagerView.snp.bottom).offset(-10)
            make.right.equalToSuperview().offset(-40)
        }
        self.leftView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(self.pagerView.snp.bottom).offset(0)
            make.width.equalTo(12)
            make.height.equalTo(32)
        }
        self.titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(self.leftView.snp.right).offset(5)
            make.width.equalTo(200)
            make.height.equalTo(30)
            make.centerY.equalTo(self.leftView.snp.centerY)
        }
        
    }
    
    func creatBtnView() -> Void {
        self.btnView.frame = CGRect.init(x: 0, y: 150, width: ScreenWidth, height: 80)
        self .addSubview(self.btnView)
        for i in 0...3 {
            let button = UIButton.init(type: .custom)
            button .setTitleColor(UIColor.red, for: .normal)
            button.tag = 100+i
            button.addTarget(self, action: #selector(clickBack), for: .touchUpInside)
            button.frame = CGRect.init(x:40+84*i, y: 0, width: 40, height: 40)
            self.btnView .addSubview(button)
            let titleLab = UILabel.init(frame: CGRect(x:40+84*i, y: 45, width: 40, height: 15))
            titleLab.textColor = TextColor
            titleLab.font = UIFont.boldSystemFont(ofSize: 12)
            titleLab.textAlignment = .center
            titleLab.tag = 200+i
            self.btnView .addSubview(titleLab)
        }
    }
    
    @objc func clickBack() -> Void {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension CommonHeaderView: FSPagerViewDelegate, FSPagerViewDataSource {
    // - FSPagerView Delegate
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.slidesList?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "ShopBannerCell", at: index)
        cell.imageView?.kf.setImage(with: URL(string:(self.slidesList?[index].imgUrl)!))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
        self.pagerControl.currentPage = index
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        delegate?.headerViewSelect()
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
}

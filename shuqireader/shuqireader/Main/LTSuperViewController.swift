//
//  LTSuperViewController.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/3.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import ESPullToRefresh
import DZNEmptyDataSet
import ATKit_Swift
import Alamofire
import SwiftyJSON
import HandyJSON
import SwiftMessages
import ESPullToRefresh

class LTSuperViewController: UIViewController {
    
    /// 全局 layout
    var layout = UICollectionViewFlowLayout()
    /// page
    var page: Int = 1
    /// 返回按钮是否隐藏 true隐藏
    var backBntHidden: Bool = false
    /// 是否清空数组
    var isClear: Bool = false
    /// 站位图片
    var noImageName: String = ""
    /// 站位标题
    var noTitle: String = ""
    /// 站位描述
    var noDes: String = ""
    /// 设置站位图
    func setNoDataViewElement(name: String = "icon_pull_animation_4",title: String = "提示",des: String = "您还没有添加购物车") -> Void {
        self.noImageName = name
        self.noTitle = title
        self.noDes = des
    }

    //修改 下拉 上拉刷新 文字提示
    var header: ESRefreshHeaderAnimator {
        get {
            let h = ESRefreshHeaderAnimator.init(frame: CGRect.zero)
            h.pullToRefreshDescription = "下拉刷新"
            h.releaseToRefreshDescription = "松开获取最新数据"
            h.loadingDescription = "下拉刷新..."
            return h
        }
    }
    
    var footer: ESRefreshFooterAnimator {
        get {
            let f = ESRefreshFooterAnimator.init(frame: CGRect.zero)
            f.loadingMoreDescription = "上拉加载更多"
            f.noMoreDataDescription = "数据已加载完"
            f.loadingDescription = "努力加载中..."
            return f
        }
    }
    
    /// 自定义翻书效果
    var makeHeader = MTRefreshHeaderAnimator.init(frame: CGRect.zero)
    var makeFotter = MTRefreshFotterAnimator.init(frame: CGRect.zero)

    deinit {
        print(self.classForCoder, "is deinit");
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = BackViewColor
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;
        self.view.backgroundColor = UIColor.white;
        self.fd_prefersNavigationBarHidden = false;
        self.fd_interactivePopDisabled = false;
        self.edgesForExtendedLayout = [];
    }
            
    
    func headerRereshing() -> Void {
        
    }
    func footerRereshing() -> Void {
        
    }
    
    
    lazy var collectionView : UICollectionView = {
        layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        if #available(iOS 11.0,*){
            collectionView.contentInsetAdjustmentBehavior = .never
            collectionView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 49, right: 0)
            collectionView.scrollIndicatorInsets = collectionView.contentInset
        }
        
        collectionView.backgroundColor = UIColor .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.frame = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeigth)
        
        collectionView.es.addPullToRefresh(animator: makeHeader) { [weak self] in
            self!.headerRereshing()
        }
        
        // 上拉加载
        collectionView.es.addInfiniteScrolling(animator: makeFotter) {
            [unowned self] in
            self.footerRereshing()
        }
        return collectionView
    }()
    
    
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:.zero, style: UITableView.Style.plain)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.backgroundColor = UIColor .white
        tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
        if #available(iOS 11.0,*){
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 49, right: 0)
            tableView.scrollIndicatorInsets = tableView.contentInset
        }
        // 下拉刷新
        tableView.es.addPullToRefresh(animator: header, handler: {
            [unowned self] in
            self.headerRereshing()
        });
        // 上拉加载
        tableView.es.addInfiniteScrolling(animator: footer) {
            [unowned self] in
            self.footerRereshing()
        }
        return tableView
    }()
    
    private lazy var leftBtn: UIButton = {
        let leftBtn = UIButton()
        leftBtn .addTarget(self, action: #selector(backBtnCiled), for: UIControl.Event.touchUpInside)
        leftBtn.frame = CGRect(x: 0, y: 0, width: 45, height: 30)
        leftBtn .contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 45, right: 30)
        leftBtn.backgroundColor = UIColor .yellow
        return leftBtn
    }()
    
    @objc func backBtnCiled() -> Void{
    }
    
    func pushDetaileVC(model: BookItemModel) -> Void {
        let view = BookDetailVC()
        view.model = model
        self.navigationController?.pushViewController(view, animated: true)
    }
    
}
extension LTSuperViewController: UIGestureRecognizerDelegate{
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true;
    }
    override var prefersStatusBarHidden: Bool{
        return false;
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default;
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait;
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return .portrait;
    }
    /// 状态栏的隐藏与显示动画样式
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
}

extension LTSuperViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{
    
    /// 返回图片
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: noImageName)
    }

    /// 返回标题文字
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let nameStr : NSMutableAttributedString = NSMutableAttributedString(string:noTitle as String, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16.0),NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        return nameStr
    }
    
    /// 返回文字详情
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .byWordWrapping
        paragraph.alignment = .center
        let nameStr: NSAttributedString = NSAttributedString(string: noDes, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0),NSAttributedString.Key.foregroundColor: UIColor.lightGray,NSAttributedString.Key.paragraphStyle:paragraph])
        return nameStr
    }
    
}




//
//  BookCityViewController.swift
//  shuqireader
//
//  Created by 李霆 on 2020/9/28.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import LTScrollView

private let glt_iphoneX = (UIScreen.main.bounds.height >= 812.0)

class BookCityViewController: UIViewController {
    
    //Mark:- headerView
    private lazy var headerView:UIView = {
        let view = UIView.init(frame: CGRect(x:0, y:0, width:ScreenWidth, height:30))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private lazy var titles: [String] = {
        return ["推荐", "男生", "女生", "优选", "首发", "全民原创"]
    }()
    
    private lazy var viewControllers: [UIViewController] = {
        let oneVc = RecommendVC()
        let twoVc = BoyVC()
        let threeVc = GirlVC()
        let fourVc = OptimizationVC()
        let fiveVc = FirstIssueVC()
        let sixVc = OriginalVC()

        return [oneVc, twoVc, threeVc, fourVc, fiveVc, sixVc]
    }()
    
    private lazy var layout: LTLayout = {
        let layout = LTLayout()
        layout.isHiddenSlider = true
        layout.isHiddenPageBottomLine = true
        layout.bottomLineColor = UIColor.yellow
        layout.lrMargin = 40
        layout.titleViewBgColor = UIColor.white
        layout.titleColor = UIColor.init(red: 190/255.0, green: 189/255.0, blue: 194/255.0, alpha:1.0)
        layout.titleSelectColor = UIColor(r: 40, g: 43, b: 53)
        layout.titleFont = UIFont.boldSystemFont(ofSize: 18)
        layout.scale = 1.2
        return layout
    }()
    
    private lazy var advancedManager: LTAdvancedManager = {
        let statusBarH = UIApplication.shared.statusBarFrame.size.height
        let advancedManager = LTAdvancedManager(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeigth), viewControllers: viewControllers, titles: titles, currentViewController: self, layout: layout, headerViewHandle: {[weak self] in
            guard let strongSelf = self else { return UIView() }
            let headerView = strongSelf.headerView
            return headerView
        })
        /* 设置代理 监听滚动 */
        advancedManager.delegate = self
        /* 设置悬停位置 */
//        advancedManager.hoverY = -navigationBarHeight
        /* 点击切换滚动过程动画 */
        //        advancedManager.isClickScrollAnimation = true
        /* 代码设置滚动到第几个位置 */
        advancedManager.scrollToIndex(index: 3)
        
        return advancedManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(advancedManager)
        advancedManagerConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension BookCityViewController : LTAdvancedScrollViewDelegate {
    //MARK: 具体使用请参考以下
    private func advancedManagerConfig() {
        //MARK: 选中事件
        advancedManager.advancedDidSelectIndexHandle = {
            print("选中了 -> \($0)")
        }
    }
    
    func glt_scrollViewOffsetY(_ offsetY: CGFloat) {
        //        print("offset --> ", offsetY)
    }
}



//
//  LTTabBarController.swift
//  shuqireader
//
//  Created by 李霆 on 2020/10/22.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class LTTabBarController: UITabBarController {
    
    private lazy var listData: [UIViewController] = {
        return [];
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isTranslucent = false;
        
        let vc = BookrackViewController.init();
        self.createCtrl(vc: vc, title:"书架", normal:"tabbar_shucheng_unselect", select:"tabbar_shucheng_select");
        let classCtrl = BookCityViewController.init();
        self.createCtrl(vc: classCtrl, title:"书城", normal:"shuchengpress", select:"shuchengpress");
        let bookCaseCtrl = WelfareViewController.init();
        self.createCtrl(vc: bookCaseCtrl, title:"福利", normal:"fuli", select:"fuli");
        let mine = MemberViewController.init();
        self.createCtrl(vc: mine, title:"会员", normal:"huiyuan-2", select:"huiyuan-2");
        let me = MeViewController.init();
        self.createCtrl(vc: me, title:"我的", normal:"tabbar_wo_unselect", select:"tabbar_wo_unselect");
        self.viewControllers = self.listData;
    }
    
    
    private func createCtrl(vc :UIViewController,title :String,normal: String,select :String) {
        let nv = LTNavViewController.init(rootViewController: vc);
        vc.showNavTitle(title: title)
        nv.tabBarItem.title = title;
        nv.tabBarItem.image = UIImage.init(named: normal)?.withRenderingMode(.alwaysOriginal);
        nv.tabBarItem.selectedImage = UIImage.init(named: select)?.withRenderingMode(.alwaysOriginal);
        nv.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : AppColor as Any], for: .selected);
        nv.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : Appx999999 as Any], for: .normal);
        self.listData.append(nv);
    }

}

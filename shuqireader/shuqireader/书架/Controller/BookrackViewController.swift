//
//  BookrackViewController.swift
//  shuqireader
//
//  Created by 李霆 on 2020/9/28.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import HandyJSON
import SwiftMessages
import ESPullToRefresh
import Flutter


class BookrackViewController: LTSuperViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "原生界面"

        let button = UIButton()
        button.frame = CGRect(x: (SCREEN_WIDTH-200)/2, y: 212, width: 200, height: 50)
        button.backgroundColor = UIColor.blue
        button .setTitle("点击进入Flutter模块", for: .normal)
        button .setTitleColor(UIColor.white, for: .normal)
        button .addTarget(self, action: #selector(pushMethod), for: .touchUpInside)
        self.view .addSubview(button)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    @objc func pushMethod() -> (Void){
        let flutterVC = FlutterVC ()
        flutterVC.splashScreenView = {
            let view = UIView.init(frame: UIScreen.main.bounds)
            view.backgroundColor = UIColor.white
            let textLab = UILabel()
            textLab.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeigth)
            textLab.text = "欢迎来到 flutter 商城模块"
            textLab.textAlignment = .center
            textLab.font = UIFont.boldSystemFont(ofSize: 30)
            view .addSubview(textLab)
            return view
        }()
        flutterVC.navigationItem.title = "商城模块开发"
        flutterVC.navBarTintColor = UIColor.init(r: 244, g: 245, b: 245)
        self.navigationController?.pushViewController(flutterVC, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    

}

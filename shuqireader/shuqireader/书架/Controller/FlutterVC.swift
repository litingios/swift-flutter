//
//  FlutterVC.swift
//  shuqireader
//
//  Created by 李霆 on 2020/11/18.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class FlutterVC: FlutterViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true

        let button = UIButton()
        button.frame = CGRect(x: SCREEN_WIDTH-60, y: 20, width: 40, height: 50)
        button.backgroundColor = UIColor.blue
        button .setTitle("返回", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button .setTitleColor(UIColor.white, for: .normal)
        button .addTarget(self, action: #selector(pushMethod), for: .touchUpInside)
        self.view .addSubview(button)
    }
    
    
    
    @objc func pushMethod() -> (Void){
        self.navigationController?.popViewController(animated: true)
    }

}

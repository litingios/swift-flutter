//
//  Tool.swift
//  shuqireader
//
//  Created by 李霆 on 2020/10/13.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import SwiftMessages

// 时间戳转成字符串
func timeIntervalChangeToTimeStr(timeInterval:Double, _ dateFormat:String? = "yyyy-MM-dd HH:mm:ss") -> String {
    let date:NSDate = NSDate.init(timeIntervalSince1970: timeInterval)
    let formatter = DateFormatter.init()
    if dateFormat == nil {
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }else{
        formatter.dateFormat = dateFormat
    }
    return formatter.string(from: date as Date)
}

// 设置圆角
func setRounded(view: UIView, _ layerWith: CGFloat = 1,_ color: UIColor, _ radius: CGFloat) -> Void {
    view.clipsToBounds = true
    view.layer.borderWidth = layerWith
    view.layer.borderColor = color.cgColor
    view.layer.cornerRadius = radius
    view.layer.masksToBounds = true
}

// 16进制颜色
func HexColor(hex:integer_t, alpha:CGFloat) -> UIColor{
    return UIColor(red: CGFloat((hex >> 16) & 0xff)/255.0, green: CGFloat((hex >> 8) & 0xff)/255.0, blue: CGFloat(hex & 0xff)/255.0, alpha: alpha)
}

func showMessageView(msg: String) -> Void {
    let status2 = MessageView.viewFromNib(layout: .statusLine)
    status2.backgroundView.backgroundColor = DominantColor
    status2.bodyLabel?.textColor = UIColor.white
    status2.configureContent(body: msg)
    var status2Config = SwiftMessages.defaultConfig
    status2Config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
    status2Config.preferredStatusBarStyle = .lightContent
    SwiftMessages.show(config: status2Config, view: status2)
}

func save(token: String) -> Void {
    let defaults = UserDefaults.standard
    defaults.set(token, forKey: "defaultKey")
    defaults.integer(forKey: "defaultKey")
    
}

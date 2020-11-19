//
//  Const.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/3.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit
import SwiftyJSON
import HandyJSON
import SwiftMessages
import Alamofire

let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeigth = UIScreen.main.bounds.size.height
let WidthScale = UIScreen.main.bounds.size.width/375.0
let kheight = (isIphoneX ? (UIScreen.main.bounds.size.height)-58 : (UIScreen.main.bounds.size.height))
let HeightScale = (ScreenHeigth >= 812.0 ? 667.0/667.0 : kheight/667.0) //667
let DominantColor = UIColor.init(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
let FooterViewColor = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)
let MainColor = UIColor.init(red: 46/255.0, green: 178/255.0, blue: 132/255.0, alpha:1.0)
let TextColor = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha:1.0)
let BackViewColor = UIColor.init(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha:1.0)
let NBackViewColor = UIColor.init(red: 211/255.0, green: 211/255.0, blue: 211/255.0, alpha:1.0)
let GreenColor = UIColor.init(red: 143/255.0, green: 199/255.0, blue: 98/255.0, alpha:1.0)
let QianGreenColor = UIColor.init(red: 242/255.0, green: 250/255.0, blue: 237/255.0, alpha:1.0)
let RedColor = UIColor.init(red: 219/255.0, green: 55/255.0, blue: 17/255.0, alpha:1.0)
let YellowColor = UIColor.init(red: 226/255.0, green: 117/255.0, blue: 52/255.0, alpha:1.0)
let QianTextColor = UIColor.init(red: 190/255.0, green: 189/255.0, blue: 194/255.0, alpha:1.0)
let BlackTextColor = UIColor.init(red: 68/255.0, green: 67/255.0, blue: 74/255.0, alpha:1.0)
let LineColor = UIColor.init(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha:1.0)



let SCREEN_WIDTH  :CGFloat  = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT :CGFloat  = UIScreen.main.bounds.size.height

let AppColor     :UIColor = LTtool.color(withHexString:"007EFE")
let Appxdddddd   :UIColor = LTtool.color(withHexString:"dddddd")
let Appx000000   :UIColor = LTtool.color(withHexString:"000000")
let Appx333333   :UIColor = LTtool.color(withHexString:"333333")
let Appx666666   :UIColor = LTtool.color(withHexString:"666666")
let Appx999999   :UIColor = LTtool.color(withHexString:"999999")
let Appxf8f8f8   :UIColor = LTtool.color(withHexString:"f8f8f8")
let Appxffffff   :UIColor = LTtool.color(withHexString:"ffffff")
let placeholder  :UIImage = UIImage.imageWithColor(color:LTtool.color(withHexString: "f8f8f8"))

let AppRadius    :CGFloat = 3
let appDatas : [String] = ["七届传说","极品家丁","择天记","神墓","遮天"]
let AppFrame :CGRect = CGRect.init(x:20, y:STATUS_BAR_HEIGHT+20, width: SCREEN_WIDTH - 40, height:CGFloat(SCREEN_HEIGHT-STATUS_BAR_HEIGHT-20-20-SAFEAREA_BOTTOM));
let GKSetInfo :String = "GKSetTheme";



// iphone X
let isIphoneX = ScreenHeigth == 812 ? true : false
// navigationBarHeight
let navigationBarHeight : CGFloat = isIphoneX ? 88 : 64
// tabBarHeight
let tabBarHeight : CGFloat = isIphoneX ? 49 + 34 : 49
// 底部安全高度
let SAFEAREA_BOTTOM : CGFloat = isIphoneX ? 34 : 0
// 状态栏高度
let STATUS_BAR_HEIGHT : CGFloat = isIphoneX ? 44 : 20

let VerticalHeight = 170*HeightScale
let VerticalWidth = (ScreenWidth-60*WidthScale)/4

let AcrossWidth = ScreenWidth-22.5
let AcrossHeight = CGFloat(130.0)



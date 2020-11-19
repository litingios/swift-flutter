//
//  AppDelegate.swift
//  shuqireader
//
//  Created by 李霆 on 2020/9/28.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import Flutter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         // Override point for customization after application launch.
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        let tab = self.customIrregularityStyle(delegate: self as? UITabBarControllerDelegate)
        self.window?.rootViewController = tab
        return true
    }

    // 加载底部tabbar样式
     func customIrregularityStyle(delegate: UITabBarControllerDelegate?) -> ESTabBarController {
        let tabBarController = ESTabBarController()
        tabBarController.delegate = delegate
        tabBarController.title = "Irregularity"
        tabBarController.tabBar.shadowImage = UIImage(named: "transparent")
        tabBarController.shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 10 {
                return true
            }
            return false
        }
        tabBarController.didHijackHandler = {
            [weak tabBarController] tabbarController, viewController, index in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
    //                let vc = FMPlayController()
    //                tabBarController?.present(vc, animated: true, completion: nil)
            }
        }
        
        let v1 = BookrackViewController()
        let v2 = BookCityViewController()
//        let v3 = WelfareViewController()
        let v3 = FlutterViewController ()
//        let v4 = MemberViewController()
        let v5 = MeViewController()
        
        v1.tabBarItem = ESTabBarItem.init(YYIrregularityBasicContentView(), title: "书架", image: UIImage(named: "tabbar_shucheng_unselect"), selectedImage: UIImage(named: "tabbar_shucheng_select"))
        v2.tabBarItem = ESTabBarItem.init(YYIrregularityBasicContentView(), title: "书城", image: UIImage(named: "shuchengpress"), selectedImage: UIImage(named: "shuchengpress"))
        v3.tabBarItem = ESTabBarItem.init(YYIrregularityBasicContentView(), title: "福利", image: UIImage(named: "fuli"), selectedImage: UIImage(named: "fuli"))
        v5.tabBarItem = ESTabBarItem.init(YYIrregularityBasicContentView(), title: "我的", image: UIImage(named: "tabbar_wo_unselect"), selectedImage: UIImage(named: "tabbar_wo_select"))

        let n1 = LTNavViewController.init(rootViewController: v1)
        let n2 = LTNavViewController.init(rootViewController: v2)
        let n3 = LTNavViewController.init(rootViewController: v3)
        let n5 = LTNavViewController.init(rootViewController: v5)

        tabBarController.viewControllers = [n1, n2, n3,n5]
        return tabBarController
    }

    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }



}


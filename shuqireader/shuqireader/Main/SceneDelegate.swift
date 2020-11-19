//
//  SceneDelegate.swift
//  shuqireader
//
//  Created by 李霆 on 2020/9/28.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import ESTabBarController_swift

var window: UIWindow?

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        let tab = self.customIrregularityStyle(delegate: self as? UITabBarControllerDelegate)
        self.window?.rootViewController = tab
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
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
        let v3 = WelfareViewController()
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
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

}


//
//  AppDelegate.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 16/8/15.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

import UIKit

// 切换控制器通知
let SwitchRootViewControllerKey = "SwitchRootViewControllerKey"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        /**
        NotificationCenter.default.addObserver(self, selector: Selector(("switchRootViewController:")), name: NSNotification.Name(rawValue: SwitchRootViewControllerKey), object: nil);*/
        NotificationCenter.default.addObserver(self, selector: #selector(switchRootViewController(notify:)), name: NSNotification.Name(rawValue: SwitchRootViewControllerKey), object: nil);
        
        UINavigationBar.appearance().tintColor = UIColor.orange;

        window = UIWindow(frame: UIScreen.main.bounds);
        window?.backgroundColor = UIColor.white;
        window?.rootViewController = defaultContoller();
        window?.makeKeyAndVisible();
        
        return true
    }
    
    /**
     用于获取默认界面
     
     :returns: 默认界面
     */
    private func defaultContoller() ->UIViewController{
        
        if AccessToken_Model.userLogin() {
            
            return isNewupdate() ? Newfeature_CollectionViewController() : WelcomeViewController();
        }
        return Main_TabBarController();
    }
    
    /// 通知的方法
    ///
    /// - Parameter notify: <#notify description#>
    func switchRootViewController(notify : Notification){
        
        let bool =  notify.object as? Bool;
        if let let_bool = bool{
            
            if let_bool == true {
                
                window?.rootViewController = Main_TabBarController();
            }
            else{
                
                window?.rootViewController = WelcomeViewController();
            }
        }
    }
    
    /// 判读当前的新的版本好
    func isNewupdate() -> Bool{
        
        //获得当前版本，info.plsit
           let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
     
        //在沙箱里拿自己的存储的版本  ?? 如果没有数据就显示""
        let sandboxVersion = UserDefaults.standard.object(forKey: "CFBundleShortVersionString") as? String ?? "";
        
        // 当前版本  2.0   以前版本 1.0  那就是降序
        if currentVersion.compare(sandboxVersion) == ComparisonResult.orderedDescending{
            
            UserDefaults.standard.set(currentVersion, forKey: "CFBundleShortVersionString");
            return true;
        }
        
        print("当前--\(currentVersion)------沙箱--\(sandboxVersion)");
        
        return false;
    }

    
    deinit {
        
        //删除通知
        NotificationCenter.default.removeObserver(self);
    }
}


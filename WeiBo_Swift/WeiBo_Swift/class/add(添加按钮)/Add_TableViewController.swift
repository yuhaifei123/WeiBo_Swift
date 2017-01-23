//
//  Add_TableViewController.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 16/8/27.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

import UIKit

class Add_TableViewController: All_TableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
     
   }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        judgeLogin();
        
        addWriteWeiBoContrro();
    }
    
    /// 判断登录问题
    func judgeLogin(){
        
        if isLogin == false {
            
            visitorView?.setupVisitorView(ishome: false, imageName: "visitordiscover_image_message", message: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知");
        }

    }
    
    
    /// 添加写微博功能
    func  addWriteWeiBoContrro(){
        
        let cv = Compose_ViewController();
        cv.delegate = self;
        let nav = UINavigationController(rootViewController: cv);
        
        present(nav, animated: true, completion: nil);
    }

  
}

extension Add_TableViewController : composeViewDelegate{
    
    internal func closeComposeViewController(season: String) {
        
        if season == Season.close.rawValue {
            
            self.tabBarController?.selectedIndex = 0
        }
    }

    
    
}

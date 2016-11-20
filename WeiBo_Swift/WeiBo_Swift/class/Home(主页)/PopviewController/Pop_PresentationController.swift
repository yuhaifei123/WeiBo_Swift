//
//  Pop_ViewController.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 2016/11/20.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

import UIKit

class Pop_ViewController: UIPresentationController {
    
    
    ///
    ///
    /// - Parameters:
    ///   - presentedViewController: 被展示的控制器
    ///   - presentingViewController: 发起的控制器
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController);
        
        
        print(presentedViewController);
    }

   
    /// 转场过程中，初始化方法
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews();
        
        //containerView 容器视图
        //presentedView  展示视图
        presentedView?.frame = CGRect(x: 100, y: 60, width: 200, height: 200);
        
        containerView?.insertSubview(backgroundView, at: 0);
    }
    
    //懒加载  背景试图
    private lazy var backgroundView : UIView = {
    
        let view = UIView();
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.2);
        view.frame = UIScreen.main.bounds;//屏幕大小
        //因为这个是 oc 的方法所以 #selector(self.closea)
        let tap = UITapGestureRecognizer(target: self, action:#selector(self.closea));
        
        view.addGestureRecognizer(tap)
        return view;
    }();
    
    
    @objc private func closea(){
        
        presentedViewController.dismiss(animated: true, completion: nil);
    }
}

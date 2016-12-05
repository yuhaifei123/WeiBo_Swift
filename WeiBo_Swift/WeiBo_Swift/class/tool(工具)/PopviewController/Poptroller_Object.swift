//
//  Poptroller_Object.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 2016/11/22.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

import UIKit

class Poptroller_Object: NSObject, UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning{
    
    var isOpen : Bool = false;
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?{
        
        return Pop_ViewController.init(presentedViewController: presented, presenting: presenting);
    }
    
    
    /// 告诉系统谁来负责modal的展示动画
    ///
    /// - Parameters:
    ///   - presented: 被展示的视图
    ///   - presenting: 发起的视图
    ///     UIViewControllerAnimatedTransitioning 是 delegate 方法
    /// - Returns: 谁来负责
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        
        isOpen = true;
        return self;
    }
    
    /// 谁负责modal关闭动画
    ///
    /// - Parameter dismissed: 被关闭的视图
    /// - Returns: 谁来负责
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        
        isOpen = false;
        return self;
    }
    
    //MARKE -- UIViewControllerAnimatedTransitioning 方法
    // 如果用这个方法，就会把以前的，动画全部消失
    
    /// 动画时间长度
    ///
    /// - Parameter transitionContext: 上下文，里面保存了动画需要的参数
    /// - Returns: 动画时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
        
        return 0.5;
    }
    
    
    /// 告诉系统如何动画，打开和关闭都一样
    ///
    /// - Parameter transitionContext: 上下文，里面保存了动画需要的参数
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        
        /** 得到控制器(展示控制器)
         let vc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to);
         
         let vca = transitionContext.viewController(forKey:UITransitionContextViewControllerKey.from);
         */
        if isOpen {
            
            //展示页面
            let view_Load = transitionContext.view(forKey: UITransitionContextViewKey.to);
            view_Load?.transform = CGAffineTransform(scaleX: 1.0, y: 0.0);
            
            //将视图加到控制器里面
            transitionContext.containerView.addSubview(view_Load!);
            //设置锚点
            view_Load?.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0);
            UIView.animate(withDuration: 0.5, animations: {() -> Void in
                
                view_Load?.transform = CGAffineTransform.identity;
            }, completion: ({(_) -> Void in
                
                //如果动画结束，一定要告诉系统
                //不然会报错
                transitionContext.completeTransition(true);
            }));
        }
        else{
            
            let view_Load = transitionContext.view(forKey: UITransitionContextViewKey.from);
            
            UIView.animate(withDuration: 0.2, animations: {
                //cgfloat 写0.0 是不能动画的
                view_Load?.transform = CGAffineTransform(scaleX: 1.0, y: 0.00001);
            }, completion: { (_) in
                //如果动画结束，一定要告诉系统
                //不然会报错
                transitionContext.completeTransition(true);
            })
        }
    }
}

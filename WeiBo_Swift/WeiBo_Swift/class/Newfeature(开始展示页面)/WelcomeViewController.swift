//
//  WelcomeViewController.swift
//  DSWeibo
//
//  Created by xiaomage on 15/9/10.
//  Copyright © 2015年 小码哥. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    /// 记录底部约束
    var bottomCons: NSLayoutConstraint?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.添加子控件
        view.addSubview(bgIV)
        view.addSubview(iconView)
        view.addSubview(messageLabel)
        
        // 2.布局子控件
        bgIV.xmg_Fill(view)

        let cons = iconView.xmg_AlignInner(type: XMG_AlignType.bottomCenter, referView: view, size: CGSize(width: 100, height: 100), offset: CGPoint(x: 0, y: -150))
        // 拿到头像的底部约束
        bottomCons = iconView.xmg_Constraint(cons, attribute: NSLayoutAttribute.bottom)
        
        messageLabel.xmg_AlignVertical(type: XMG_AlignType.bottomCenter, referView: iconView, size: nil, offset: CGPoint(x: 0, y: 20))
        
        // 3.设置用户头像
        if let iconUrl = AccessToken_Model.loadAccessToken()?.avatar_large
        {
            let url = NSURL(string: iconUrl)!
            iconView.sd_setImage(with: url as URL!)
        }
    }
    
    // 97606813
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        bottomCons?.constant = -UIScreen.main.bounds.height -  bottomCons!.constant
        print(-UIScreen.main.bounds.height)
        print(bottomCons!.constant)
        // -736.0 + 586.0 = -150.0
        print(-UIScreen.main.bounds.height -  bottomCons!.constant)
        
        // 3.执行动画
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
                // 头像动画
                self.iconView.layoutIfNeeded()
            }) { (_) -> Void in
 
                // 文本动画
                UIView.animate( withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
                    self.messageLabel.alpha = 1.0
                    }, completion: { (_) -> Void in
                       // 去主页  发送通知
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: SwitchRootViewControllerKey), object: true, userInfo: nil);
                })
        }
        
    }
    
    // MARK: -懒加载
    private lazy var bgIV: UIImageView = UIImageView(image: UIImage(named: "ad_background"))
    
    private lazy var iconView: UIImageView = {
       let iv = UIImageView(image: UIImage(named: "avatar_default_big"))
        iv.layer.cornerRadius = 50
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var messageLabel: UILabel = {
       let label = UILabel()
        label.text = "欢迎回来"
        label.sizeToFit()
        label.alpha = 0.0
        return label
    }()
}

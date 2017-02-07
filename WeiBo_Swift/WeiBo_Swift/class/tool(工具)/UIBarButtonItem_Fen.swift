//
//  UINavigationBar_Fen.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 16/10/5.
//  Copyright © 2016年 虞海飞. All rights reserved.
/// UINavigationBar 的分类

import UIKit

extension UIBarButtonItem{

    class func ItemBut(imageNameN : String,target: Any?, action: Selector) -> UIBarButtonItem{

    let leftBut = UIButton();
    leftBut.setBackgroundImage(UIImage(named: imageNameN), for: UIControlState.normal);
    leftBut.setBackgroundImage(UIImage(named: imageNameN+"_highlighted"), for: UIControlState.highlighted);
    leftBut.addTarget(target, action: action, for: UIControlEvents.touchUpInside);
    leftBut.sizeToFit();

    return UIBarButtonItem(customView: leftBut);
    }

    
    /// 快速创建，其实就是 init 方法
    ///
    /// - Parameters:
    ///   - imageNameN: 
    ///   - target: <#target description#>
    ///   - action: <#action description#>
    convenience init(imageNameN : String,target: Any?, action: String?) {
        
        let leftBut = UIButton();
        leftBut.setBackgroundImage(UIImage(named: imageNameN), for: UIControlState.normal);
        leftBut.setBackgroundImage(UIImage(named: imageNameN+"_highlighted"), for: UIControlState.highlighted);
        if let aa = action {
           
            leftBut.addTarget(target, action: Selector(aa), for: UIControlEvents.touchUpInside);
        }
        leftBut.sizeToFit();
        
        self.init(customView: leftBut);
        
    }
}

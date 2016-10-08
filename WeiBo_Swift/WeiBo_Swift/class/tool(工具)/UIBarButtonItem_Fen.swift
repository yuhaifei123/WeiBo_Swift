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

}

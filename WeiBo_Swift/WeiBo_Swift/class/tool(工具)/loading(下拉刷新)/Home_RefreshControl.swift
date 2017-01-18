//
//  Home_RefreshControl.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 2017/1/18.
//  Copyright © 2017年 虞海飞. All rights reserved.
//

import UIKit

class Home_RefreshControl: UIRefreshControl {

    override init() {
        super.init();
        
        setupUI();
    }
    
    
    private func setupUI(){
        
        
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
  }

/// 子类，与 HomeRefreshView.xib 相同
class HomeRefreshView : UIView {
    
    class func refreshView() -> HomeRefreshView{
        
        //得到最后一个
        return Bundle.main.loadNibNamed("HomeRefreshView", owner: nil, options: nil)?.last as! HomeRefreshView;
    }
}

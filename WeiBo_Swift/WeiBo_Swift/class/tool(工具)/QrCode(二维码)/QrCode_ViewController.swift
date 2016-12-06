//
//  QrCode_ViewController.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 2016/11/26.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

import UIKit

class QrCode_ViewController: UIViewController {
    
    
    /// 二维码 view
    @IBOutlet weak var view_QRCode: UIView!
    /// 视图 view的高度
    @IBOutlet weak var layoutView_Height: NSLayoutConstraint!
    /// 冲击波 top
    @IBOutlet weak var layyoutCJB_Top: NSLayoutConstraint!
    /// 选择，条形码与二维码
    @IBOutlet weak var tabBar: UITabBar!
    /// 关闭 Bar
    @IBOutlet weak var guanBar: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        //冲击波的头部与 view 的高度相反
        self.layyoutCJB_Top.constant = -self.layoutView_Height.constant;
        //牢记，就是"自动布局"里面改变了，就要刷新一下 view
        self.view_QRCode.layoutIfNeeded();
        //动画方法
        UIView.animate(withDuration: 5.0, animations: {() -> Void in
            //设置约束
            self.layyoutCJB_Top.constant = self.layoutView_Height.constant/2;
            //设置动画次数
            UIView.setAnimationRepeatCount(MAXFLOAT);
            //必须更新一下
            self.view_QRCode.layoutIfNeeded();
        });
    }
    
    /// 加载完成以后，触发事件
    ///
    /// - Parameter animated: <#animated description#>
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        tabBar.selectedItem = tabBar.items![0];
    }

    
    /// 点击关闭按钮，触发事件
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func guanBarClick(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil);
    }
}

//
//  QrCode_ViewController.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 2016/11/26.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

import UIKit

class QrCode_ViewController: UIViewController {
    
    
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

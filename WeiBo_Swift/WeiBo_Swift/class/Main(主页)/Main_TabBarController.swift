//
//  Main_TabBarController.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 16/8/15.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

import UIKit

class Main_TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    /**
      加载完页面以后实现

     - parameter animated: <#animated description#>
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);

        add_button();

        addChildViewControllers();
    }

    /**
     添加所有子控制
     */
    func addChildViewControllers() {
        addChildViewController(Home_TableViewController(), title: "首页", imageName: "tabbar_home");
        addChildViewController(Message_TableViewController(), title: "消息", imageName: "tabbar_message_center");

        addChildViewController(Add_TableViewController(), title: "", imageName: "");

        addChildViewController(Discover_TableViewController(), title: "发现", imageName: "tabbar_discover");
        addChildViewController(Profile_TableViewController(), title: "我", imageName: "tabbar_profile");
    }

    /**
     初始化子控制器

     :param: childController 需要初始化的子控制器
     :param: title           初始化的标题
     :param: imageName       初始化的图片
     */
    func addChildViewController(_ childController: UIViewController, title:String, imageName:String) {

        // 从内像外设置, nav和tabbar都有
        childController.title = title
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")

        // 注意: Xocde7之前只有文字有效果, 还需要设置图片渲染模式
        tabBar.tintColor = UIColor.orange

        // 2.创建导航控制器
        let nav = UINavigationController()
        nav.addChildViewController(childController)

        // 3.添加控制器到tabbarVC
        addChildViewController(nav)
    }

    /**
     添加button
     */
    fileprivate func add_button(){

        tabBar.addSubview(button_Add);

        // 1.计算按钮宽度
        let width = tabBar.bounds.width / 5;
        // 2.创建按钮frame
        let rect = CGRect(x: 0, y: 0, width: width, height: tabBar.bounds.height);
        // 3.设置按钮frame和偏移位
        button_Add.frame = rect.offsetBy(dx: width * 2, dy: 0);
    }

    fileprivate lazy var button_Add : UIButton = {

        let button = UIButton();
        //设置图片
        button.setImage(UIImage (named: "tabbar_compose_icon_add"), for: UIControlState());
        button.setImage(UIImage (named: "tabbar_compose_icon_add_highlighted"), for: UIControlState.highlighted);

        // 3.设置背景图片
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button"), for: UIControlState())
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), for: UIControlState.highlighted)

        return button;
    }();

}

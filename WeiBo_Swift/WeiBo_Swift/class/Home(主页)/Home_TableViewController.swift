//
//  Home_TableViewController.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 16/8/15.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

import UIKit

class Home_TableViewController: All_TableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if isLogin == false {

            visitorView?.setupVisitorView(ishome: true, imageName: "visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜");
        }
        else{

            navButton();
        }
    }

    ///登陆成功了，就是设置navitem的按钮
    private func navButton(){

       //设置控制器，左右
       navigationItem.leftBarButtonItem =  UIBarButtonItem.ItemBut(imageNameN: "navigationbar_friendattention", target: self, action: #selector(self.leftBtnClick));

        navigationItem.rightBarButtonItem = UIBarButtonItem.ItemBut(imageNameN: "navigationbar_pop", target: self, action: #selector(self.rightButClick));

        let titleButton = ButtonTitle();
        titleButton.setTitle("aaaaaa ", for: UIControlState.normal);
               titleButton.addTarget(self, action: #selector(self.titeButton(btn:)), for: UIControlEvents.touchUpInside);

        navigationItem.titleView = titleButton;
    }


    @objc private func titeButton(btn : UIButton){

        btn.isSelected = !btn.isSelected;
    }

    func  leftBtnClick(){

        print("aaaa");
    }

    func rightButClick(){

        print("bbbbb");
    }
}

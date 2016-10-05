//
//  Add_TableViewController.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 16/8/27.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

import UIKit

class Add_TableViewController: All_TableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if isLogin == false {

            visitorView?.setupVisitorView(ishome: false, imageName: "visitordiscover_image_message", message: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知");
        }

    }


}

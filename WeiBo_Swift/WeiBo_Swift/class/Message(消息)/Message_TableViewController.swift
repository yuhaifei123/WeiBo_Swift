//
//  Message_TableViewController.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 16/8/15.
//  Copyright © 2016年 虞海飞. All rights reserved.
//  消息TableView

import UIKit

class Message_TableViewController: All_TableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if isLogin == false {

            visitorView?.setupVisitorView(ishome: false, imageName: "visitordiscover_image_message", message: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知");
        }
    }

}

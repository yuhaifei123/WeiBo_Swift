//
//  All_TableViewController.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 16/8/15.
//  Copyright © 2016年 虞海飞. All rights reserved.
//  共有的uitableview

import UIKit

class All_TableViewController: UITableViewController,VisitorViewDelegate{

    var isLogin : Bool?;
    var visitorView : VisitorView?;

    override func loadView() {

        isLogin = false;

        isLogin == true ? super.loadView() : setupVisitorView();

        //设置nav控制请
        navigationItem.leftBarButtonItem  = UIBarButtonItem(title: "登陆", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.loginBtnWillClick));
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.registerBtnWillClick))
    }


    ///没有登陆，页面展r示
    private func setupVisitorView(){

        view = VisitorView();
        visitorView = view as! VisitorView!;
        visitorView?.delegate = self;
    }
    
    func loginBtnWillClick() {
        print("aaaa");
    }

    func registerBtnWillClick() {
        print("bbbb");
    }
}

//
//  All_TableViewController.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 16/8/15.
//  Copyright © 2016年 虞海飞. All rights reserved.
//  共有的uitableview

import UIKit

class All_TableViewController: UITableViewController {

    var isLogin : Bool?;
    var visitorView : VisitorView?;

    override func loadView() {

        isLogin = false;

        isLogin == true ? super.loadView() : setupVisitorView();

    }


    ///没有登陆，页面展r示
    private func setupVisitorView(){

        view = VisitorView();
        visitorView = view as! VisitorView!;
    }
    

}

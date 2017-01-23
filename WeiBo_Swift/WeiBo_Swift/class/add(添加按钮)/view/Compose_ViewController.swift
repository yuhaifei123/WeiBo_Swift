//
//  Compose_ViewController.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 2017/1/20.
//  Copyright © 2017年 虞海飞. All rights reserved.
//  写微博view

import UIKit


/// 定义枚举
///
/// close -- 关闭了控制器
enum Season : String{
    case close = "close"
}

//定义协议
protocol composeViewDelegate {
    func closeComposeViewController(season:String);
}



class Compose_ViewController: UIViewController {

    var delegate:composeViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white;
        
        setUpView();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    func setUpView(){
        
        addNavView();
        
    }
    
    /// 添加 nav 方法
    func addNavView(){
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.plain, target: self, action:#selector(navItemClose));
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: UIBarButtonItemStyle.plain, target: self, action: #selector(published));
        //不能点击
        self.navigationItem.rightBarButtonItem?.isEnabled = false;
        
        //添加微博 title
        topview.addSubview(label1);
        topview.addSubview(label2);
        self.navigationItem.titleView = topview;
        
        label1.snp.makeConstraints { (make) in
            
            make.top.equalTo(0);
            make.left.equalTo(0);
            make.right.equalTo(0);
            make.height.equalTo(14);
        }
        
        label2.snp.makeConstraints { (make) in
            
            make.top.equalTo(label1.snp.bottom).offset(2);
            make.height.equalTo(label1.snp.height);
            make.left.equalTo(label1.snp.left);
            make.width.equalTo(label1.snp.width);
        }
    }
    
    /// 点击关闭，监听
    func navItemClose(){
        self.tabBarController!.selectedIndex = 0;

    }
    
    /// 点击发表，监听
    func published(){
        
    }
    
    // MARK - 懒加载
    public lazy var topview : UIView = {
    
        let view = UIView();
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 32);
        
        return view;
    }();
    
    
    public lazy var label1 : UILabel = {
        
        let label1 : UILabel = UILabel();
        label1.text = "发送微博"
        label1.font = UIFont.systemFont(ofSize: 15)
        label1.sizeToFit();
        
        return label1;
    }();
    
    
    public lazy var label2 : UILabel = {
    
        let label2 : UILabel = UILabel();
        label2.text = "weiBoDemo"
        label2.font = UIFont.systemFont(ofSize: 13);
        label2.textColor = UIColor.darkGray;
        label2.sizeToFit();

        return label2;
    }();
    
    
 }

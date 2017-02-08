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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        //开启键盘
        // 主动召唤键盘
        txteView.becomeFirstResponder();
         self.tabBarController?.tabBar.isHidden = true;
        
        //监听键盘
        NotificationCenter.default.addObserver(self, selector: #selector(keyNotification(ntf:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil);
    }
    
    /// 要关闭
    ///
    /// - Parameter animated: <#animated description#>
    override func viewWillDisappear(_ animated: Bool) {
        
        // 主动隐藏键盘
        txteView.resignFirstResponder();
         self.tabBarController?.tabBar.isHidden = false;
    }
    
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    func setUpView(){
        
        addNavView();
        addToolBar();
    }
    
    /// 添加 nav 方法
    private func addNavView(){
        
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
        
        //添加 uitextView
        txteView.addSubview(promptLabel);
        self.view.addSubview(txteView);
        
        promptLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(8);
            make.left.equalTo(5);
            make.width.equalTo(200);
        }
    
        txteView.snp.makeConstraints { (make) in
        
            make.top.equalTo(0);
            make.left.equalTo(0);
            make.right.equalTo(0);
            make.height.equalTo(self.view).multipliedBy(0.4);
        }

    }
    
    
    /// 添加底部的工具条
    func addToolBar(){
        
        self.view.addSubview(toolbar);
        
        var items = [UIBarButtonItem]();
        
        let itemSettings = [["imageName": "compose_toolbar_picture", "action": "selectPicture"],
                            
                            ["imageName": "compose_mentionbutton_background"],
                            
                            ["imageName": "compose_trendbutton_background"],
                            
                            ["imageName": "compose_emoticonbutton_background", "action": "inputEmoticon"],
                            
                            ["imageName": "compose_addbutton_background"]];
        for dic in itemSettings {
            
            let item = UIBarButtonItem(imageNameN: dic["imageName"]!, target: self, action: dic["action"]);
            items.append(item);
          //  items.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil))
            let spacingItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action:  nil);
           items.append(spacingItem);
        }
        
        items.removeLast();
        
        toolbar.items = items;
        
        //布局大小
        toolbar.snp.makeConstraints { (make) in
            
            make.right.equalTo(0);
            make.left.equalTo(0);
            make.bottom.equalTo(0);
            make.height.equalTo(44);
        }
    }
    
    /// 点击关闭，监听
    func navItemClose(){
        self.tabBarController!.selectedIndex = 0;

    }
    
    /// 键盘监听通知
    func keyNotification(ntf:Notification){
        
        let value = ntf.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue;
        let rectValue = value.cgRectValue;
        let Y = rectValue.origin.y;
        //屏幕的高度
        let screenHeight =  UIScreen.main.bounds.height;
        let number = ntf.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber;
        
        self.toolbar.snp.updateConstraints { (make) in
            make.bottom.equalTo((screenHeight - Y) * -1);
            
        }
        UIView.animate(withDuration: number.doubleValue) {
           
            self.view.layoutIfNeeded();
        }
        
       
        
    }
    
    /// 点击发表，监听
    func published(){
        
        let path = "2/statuses/update.json";
        let params : [String : Any] = ["access_token":"weibo", "status": txteView.text];
        AFNetworkTools.shareNetwork().post(path, parameters: params, progress: { (_) in
           
        }, success: { (_, JSON) in
            
            
            // 1.提示用户发送成功
            SVProgressHUD.showSuccess(withStatus: "发送成功");
            self.navItemClose();
        }) { (_, _) in
            
            // 3.提示用户发送失败
            SVProgressHUD.showError(withStatus: "发送失败");
        }
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
    
    //设置提示输入框
    public lazy var txteView : UITextView = {
    
        let textView = UITextView();
        textView.delegate = self;
        //可以上下滚动
        textView.alwaysBounceVertical = true;
        //滚动后键盘消失
        textView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag;
        
        return textView;
    }();

    //提示 lable
    public lazy var promptLabel : UILabel = {
    
        let label = UILabel();
        label.text = "分享新鲜事...";
        label.font = UIFont.systemFont(ofSize: 13);
        label.textColor = UIColor.darkGray;
        
        return label;
    }();
    
    //工具栏
    public lazy var toolbar : UIToolbar = UIToolbar();
    
 }

extension Compose_ViewController : UITextViewDelegate{
    
    
    /// textView 开始编辑
    ///
    /// - Parameter textView: <#textView description#>
    func textViewDidChange(_ textView: UITextView) {
        
        //是不是有字体
        let hasText = txteView.hasText;
        
        promptLabel.isHidden = hasText;
        self.navigationItem.rightBarButtonItem?.isEnabled = hasText;
    }
}

//
//  VisitorView.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 16/10/2.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

import UIKit
import SnapKit

///swift 中的协议
protocol VisitorViewDelegate : NSObjectProtocol{


    func loginBtnWillClick();

    func registerBtnWillClick();
}
                
///登陆没有成功，所展示的view
class VisitorView: UIView {

    var delegate : VisitorViewDelegate?;

    //获取屏幕大小
    var bou:CGRect = UIScreen.main.bounds;

    ///设置首页的页面样式，
    public func setupVisitorView(ishome : Bool, imageName : String,message : String){

        //是否隐藏
        iconView.isHidden = !ishome;
        homeIcon.image = UIImage(named:imageName);
        messageLabel.text = message;

        if ishome == true  {

            startRotate();
        }
    }

    ///用代码，先界面
    override init(frame: CGRect) {
        super.init(frame: frame);

        self.addSubview(iconView);
        self.addSubview(homeIcon);
        self.addSubview(messageLabel);
        self.addSubview(loginButton);
        self.addSubview(registerButton);


        iconView.frame.origin = CGPoint(x: (bou.width - iconView.frame.size.width)/2, y: (bou.height - iconView.frame.size.height)/2);

        homeIcon.frame.origin = CGPoint(x: (bou.width - homeIcon.frame.size.width)/2, y: (bou.height - homeIcon.frame.size.height)/2);

        messageLabel.frame = CGRect(x: (bou.width - 180)/2, y: homeIcon.frame.maxY-30, width: 200, height: 200);

        loginButton.frame = CGRect(x: messageLabel.frame.origin.x, y: messageLabel.frame.maxY-60, width: 60, height: 30);

        registerButton.frame = CGRect(x: messageLabel.frame.maxX - 60, y: loginButton.frame.origin.y, width: 60, height: 30);

    }

    ///转盘启动动画
    private func startRotate(){
        let rotateAni = CABasicAnimation(keyPath: "transform.rotation")
        rotateAni.fromValue = 0.0
        rotateAni.toValue = M_PI * 2.0
        rotateAni.duration = 10
        rotateAni.repeatCount = MAXFLOAT
        //不停的转动
        rotateAni.isRemovedOnCompletion = false;
        iconView.layer.add(rotateAni, forKey: nil);
    }

    ///在swif中，只能用一种创建，要么代码，要么xib/SB
    required init?(coder aDecoder: NSCoder) {
        ///报错
        fatalError("init(coder:) has not been implemented")
    }

    //登陆按钮监听
    func  loginBtnClick(){

        delegate?.loginBtnWillClick();
    }

    //注册按钮监听
    func registerBtnClick(){

        delegate?.registerBtnWillClick();
    }

    ///懒加载，转盘
    private lazy var iconView : UIImageView = {

        var ic = UIImageView(image: UIImage(named:"visitordiscover_feed_image_house-1"));
        return ic;
    }();

    ///图标
    private lazy var homeIcon : UIImageView = {

        var ic = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"));
        return ic;
    }();

    /// 文本
    private lazy var messageLabel : UILabel = {

        var la = UILabel();
        la.text = "发生的反馈技术的合法服哈时空裂缝哈啥啥";
        la.textColor = UIColor.green;
        //可以自动换行
        la.numberOfLines = 0;
        return la;
    }();

    ///登陆按钮
    private lazy var loginButton : UIButton = {

        var bu = UIButton();
        bu.setTitle("登陆", for: UIControlState.normal);
        bu.setTitleColor(UIColor.red, for: UIControlState.normal);
        bu.setBackgroundImage(UIImage(named:"common_button_white_disable"), for: UIControlState.normal);
        //按钮，点击监听
     //   bu.addTarget(self, action: loginBtnClick(), for: UIControlEvents.touchDown);
      //  bu.addTarget(self, action: , for: UIControlEvents.touchUpInside);
        bu.addTarget(self, action: #selector(VisitorView.loginBtnClick), for: UIControlEvents.touchUpInside);
        return bu;
    }();



    ///注册按钮
    private lazy var registerButton : UIButton = {

        var bu = UIButton();
        bu.setTitle("注册", for: UIControlState.normal);
        bu.setTitleColor(UIColor.red, for: UIControlState.normal);
        bu.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: UIControlState.normal);
        bu.addTarget(self, action: #selector(VisitorView.registerBtnClick), for: UIControlEvents.touchUpInside);
        return bu;
    }();
}

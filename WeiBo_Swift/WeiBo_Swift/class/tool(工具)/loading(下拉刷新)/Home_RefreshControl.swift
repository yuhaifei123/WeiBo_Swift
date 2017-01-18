//
//  Home_RefreshControl.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 2017/1/18.
//  Copyright © 2017年 虞海飞. All rights reserved.
//

import UIKit

class Home_RefreshControl: UIRefreshControl {

    override init() {
        super.init();
        
        setupUI();
    }
    
    /// 页面设置
    private func setupUI(){
        self.addSubview(homeRefreshView);
        homeRefreshView.snp.makeConstraints { (make) in
            
            make.size.equalTo(CGSize(width: 170, height:70.0 ));
            make.center.equalTo(self);
        };
        
        //kvc 添加观察者
        self.addObserver(self, forKeyPath: "frame", options: NSKeyValueObservingOptions.new, context: nil);
    }
    
    
    /// 结束刷新
    override func endRefreshing() {
        super.endRefreshing();
        
        homeRefreshView.stopLoadingAnimation();
        loadingfloat = false;
    }
    
    //判断值，判断箭头方向
    private var arrow : Bool = false;
    //判断是不是转转圈圈
    private var loadingfloat : Bool = false;
    
    ///
    /// kvc 监听方法
    /// - Parameters:
    ///   - keyPath: <#keyPath description#>
    ///   - object: <#object description#>
    ///   - change: <#change description#>
    ///   - context: <#context description#>
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //控件的 Y
        let viewY = self.frame.origin.y;
        if viewY >= 0 {
            
            return;
        }
        
        // 下啦到一定程度，程序自己刷新是
        if isRefreshing == true && loadingfloat == false{
            
            homeRefreshView.startLoadingAnimation();
            loadingfloat = true;
        }
        
        if viewY >= -50 && arrow == false {
            
            homeRefreshView.rotaionArrowItem();
            print("翻转");
            arrow = true;
        }
        else if viewY < -50 && arrow == true {
            homeRefreshView.rotaionArrowItem();
            print("开始翻转");
            arrow = false;
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //对象销毁，会调用这个方法。防止循环引用
    deinit {
        
        removeObserver(self, forKeyPath: "frame");
    }
    
    private lazy var homeRefreshView : HomeRefreshView = HomeRefreshView.refreshView();
    
  }

/// 子类，与 HomeRefreshView.xib 相同
class HomeRefreshView : UIView {

    /// 箭头
    @IBOutlet weak var imageView_ArrowItem: UIImageView!
    /// 圆圆圈
    @IBOutlet weak var imageView_Loading: UIImageView!
    /// 圆圆圈view
    @IBOutlet weak var view_LoadView: UIView!
    
    ///选择箭头
    func rotaionArrowItem(){
        
        UIView.animate(withDuration: 0.2) {
            //动画效果
            //transform 形变后的 frame
            self.imageView_ArrowItem.transform = self.imageView_ArrowItem.transform.rotated(by: CGFloat(M_PI));
        }
    }

    /// 开始转圈圈动画
    func startLoadingAnimation() {
        
        //把前面的view 隐藏了
        self.view_LoadView.isHidden = true;
        
        let rotateAni = CABasicAnimation(keyPath: "transform.rotation")
        rotateAni.fromValue = 0.0
        rotateAni.toValue = M_PI * 2.0
        rotateAni.duration = 10
        rotateAni.repeatCount = MAXFLOAT
        //不停的转动
        rotateAni.isRemovedOnCompletion = false;
        imageView_Loading.layer.add(rotateAni, forKey: nil);
    }
    
    
    /// 停止转圈圈动画
    func stopLoadingAnimation(){
        
        self.view_LoadView.isHidden = false;
        
        //停止动画
        imageView_Loading.stopAnimating();
    }
    
    class func refreshView() -> HomeRefreshView{
        
        //得到最后一个
        return Bundle.main.loadNibNamed("HomeRefreshView", owner: nil, options: nil)?.last as! HomeRefreshView;
    }
}

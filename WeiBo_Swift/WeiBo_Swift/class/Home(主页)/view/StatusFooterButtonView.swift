//
//  StatusFooterButtonView.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 2017/1/9.
//  Copyright © 2017年 虞海飞. All rights reserved.
//  底部 button 的 view

import UIKit

class StatusFooterButtonView: UIView {

  
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        addView();
    }
    
    private func addView(){
        
        addSubview(retweetBtn);
        addSubview(unlikeBtn);
        addSubview(commonBtn);
        
        let b : Double  = 1/3;
        retweetBtn.snp.makeConstraints { (make) in
            make.top.equalTo(0);
            make.left.equalTo(0);
            make.width.equalTo(self).multipliedBy(b);
            make.height.equalTo(self).offset(2);
        }
        
        unlikeBtn.snp.makeConstraints { (make) in
            
            make.top.equalTo(retweetBtn.snp.top);
            make.left.equalTo(retweetBtn.snp.right);
            make.height.equalTo(retweetBtn.snp.height);
            make.width.equalTo(retweetBtn.snp.width);
        }
        
        
        commonBtn.snp.makeConstraints { (make) in
            
            make.top.equalTo(unlikeBtn.snp.top);
            make.left.equalTo(unlikeBtn.snp.right);
            make.height.equalTo(unlikeBtn.snp.height);
            make.width.equalTo(unlikeBtn.snp.width);
        }
        
    }
    
    /// 转发
    private lazy var retweetBtn : UIButton = {
        
        let button = UIButton();
        button.setImage(UIImage(named: "timeline_icon_retweet"), for: UIControlState.normal);
        button.setTitle("转发", for: UIControlState.normal);
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10);
        button.setBackgroundImage(UIImage(named:"timeline_card_bottom_background"), for: UIControlState.normal);
        //字体之间的间距
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0);
        
        return button;
    }();
    
    // 赞
    private lazy var unlikeBtn : UIButton = {
        
        let button = UIButton();
        button.setImage(UIImage(named: "timeline_icon_unlike"), for: UIControlState.normal);
        button.setTitle("赞", for: UIControlState.normal);
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10);
        button.setBackgroundImage(UIImage(named:"timeline_card_bottom_background"), for: UIControlState.normal);
        //字体之间的间距
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0);
        
        return button;
    }();
    
    // 评论
    private lazy var commonBtn: UIButton = {
        
        let button = UIButton();
        button.setImage(UIImage(named: "timeline_icon_comment"), for: UIControlState.normal);
        button.setTitle("评论", for: UIControlState.normal);
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10);
        button.setBackgroundImage(UIImage(named:"timeline_card_bottom_background"), for: UIControlState.normal);
        //字体之间的间距
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0);
        
        return button;
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

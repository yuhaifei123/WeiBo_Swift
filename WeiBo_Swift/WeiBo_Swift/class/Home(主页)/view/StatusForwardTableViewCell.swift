//
//  StatusForwardTableViewCell.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 2017/1/9.
//  Copyright © 2017年 虞海飞. All rights reserved.
//  转发 view

import UIKit

class StatusForwardTableViewCell: Home_TableViewCell {
    
    /// 添加 ui
    override func setupUI() {
        super.setupUI();
        
        //转发的 button 在 contentView 下面添加（其实就是添加顺序）
        contentView.insertSubview(forwardButton, belowSubview: contentLabel);
        //forwardLabel 在forwardButton上面添加 （其实就是添加顺序）
        contentView.insertSubview(forwardLabel, aboveSubview: forwardButton);
    
        if forwardLabel.text == nil || forwardLabel.text == "" {
            
            forwardLabel.snp.makeConstraints { (make) in
                
                make.top.equalTo(contentLabel.snp.bottom).offset(0);
                make.left.equalTo(contentLabel.snp.left);
                make.right.equalTo(-10);
                make.height.equalTo(0);
            }
        }
        else{
            
            forwardLabel.snp.makeConstraints { (make) in
                
                make.top.equalTo(contentLabel.snp.bottom).offset(0);
                make.left.equalTo(contentLabel.snp.left);
                make.right.equalTo(-10);
                make.bottom.equalTo(pictureView.snp.top).offset(0);
            }
        }
      
            
        forwardButton.snp.makeConstraints { (make) in
            
            make.top.equalTo(contentLabel.snp.bottom);
            make.left.equalTo(10);
            make.right.equalTo(-10);
            make.height.equalTo(0.0);
        };
    }
    
    
    ///修改布局
    override func updateUI() {
        super.updateUI();
        
        if size.height != 0.0 {
            
            forwardButton.snp.updateConstraints { (make) in
                make.height.equalTo(size.height + 10)
            }
        }
        
        forwardButton.snp.updateConstraints { (make) in
            make.height.equalTo(0.0);
        }
    }
    
    /// MARK -- 懒加载
    private lazy var forwardLabel : UILabel =  {
        
        let label = UILabel();
        label.textColor = UIColor.darkGray;
        //字体的大小
        label.font = UIFont.systemFont(ofSize: 15);
        //自动换行
        label.numberOfLines = 0;
        //必须申明行 width
        label.preferredMaxLayoutWidth = UIScreen.main.bounds.width-20;
        return label;
    }();
    
    /// 转发 button
    private lazy var forwardButton : UIButton = {
    
        let button = UIButton();
        button.backgroundColor = UIColor(white: 0.9, alpha: 1.0);
        
        return button;
    }();
}

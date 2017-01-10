//
//  StatusForwardTableViewCell.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 2017/1/9.
//  Copyright © 2017年 虞海飞. All rights reserved.
//

import UIKit

class StatusForwardTableViewCell: Home_TableViewCell {

    
    /// 添加 ui
    override func setupUI() {
        super.setupUI();
        
        //转发的 button 在 contentView 下面添加（其实就是添加顺序）
        contentView.insertSubview(forwardButton, belowSubview: contentLabel);
        //forwardLabel 在forwardButton上面添加 （其实就是添加顺序）
        contentView.insertSubview(forwardLabel, aboveSubview: forwardButton);
        
        /*
        footerView.snp.remakeConstraints { (make) in
             make.top.equalTo(pictureView.snp.bottom).offset(10);
        }
 */
        contentLabel.snp.remakeConstraints { (make) in
            make.bottom.equalTo(pictureView.snp.top).offset(-5);
        }
        //正文
        contentLabel.snp.makeConstraints { (make) in
            
             make.bottom.equalTo(forwardLabel.snp.top).offset(-5);
        }
        forwardLabel.text = "fsfsfdsfsfsdfdsfsdfsdfsdfsfsdfsfdsfsfdsfssd";
        forwardLabel.snp.makeConstraints { (make) in
            
          // make.top.equalTo(contentLabel.snp.bottom).offset(10);
           // make.left.equalTo(contentLabel.snp.left);
           // make.bottom.equalTo(forwardButton.snp.top).offset(-10);
            make.bottom.equalTo(pictureView.snp.top).offset(-10);
        }
        
        /*
        forwardButton.snp.makeConstraints { (make) in
          //  make.top.equalTo(forwardLabel.snp.top);
            make.left.equalTo(contentLabel.snp.left);
            make.right.equalTo(topView.snp.right);
            make.bottom.equalTo(footerView.snp.top).offset(-100);
        }
 */
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
        button.backgroundColor = UIColor.red;  //UIColor(white: 0.9, alpha: 1.0);
        
        return button;
    }();
}

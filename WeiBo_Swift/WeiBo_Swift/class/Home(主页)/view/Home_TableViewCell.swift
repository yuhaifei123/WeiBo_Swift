//
//  Home_TableViewCell.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 2016/12/22.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

import UIKit

class Home_TableViewCell: UITableViewCell {

    //根据，图片（九宫格图片）大小
    var size : CGSize = CGSize(width: 0.001, height: 0.001);
    
    var status : Status? {
    
        didSet{
            
            //设置 topview 数据
            topView.status = status;
            contentLabel.text = status?.text;
            pictureView.status = status;
            size = pictureView.calculateImageSize();
            pictureView.snp.updateConstraints { (make) in
                make.size.equalTo(size);
            }
            
            updateUI();
        }
    }
    
    func updateUI(){
        
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        setupUI();

    }
    
    /// 添加 view
    public func setupUI(){
        
        //控制器 view，添加 view
        contentView.addSubview(topView);
        contentView.addSubview(contentLabel);
        contentView.addSubview(footerView);
        contentView.addSubview(pictureView);
        //view 布局
        
        topView.snp.makeConstraints { (make) in
            
            make.left.equalTo(10);
            make.right.equalTo(-10);
            make.top.equalTo(10);
            make.height.equalTo(60);
        }
        
        //正文
        contentLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(topView.snp.bottom).offset(10);
            make.left.equalTo(topView.snp.left);
            make.bottom.equalTo(pictureView.snp.top).offset(-5);
        }
        
        //配图
        pictureView.snp.makeConstraints { (make) in
            
            make.left.equalTo(10);
            make.size.equalTo(CGSize(width: 0.01, height: 0.01));
        }
        
        footerView.snp.makeConstraints { (make) in
            
            make.top.equalTo(pictureView.snp.bottom).offset(10);
            make.height.equalTo(44);
            make.left.equalTo(0);
            make.right.equalTo(0);
           // make.bottom.equalTo(contentView).offset(0);
        }
    }
    
    /**
     用于获取行号
     */
    func rowHeight(status: Status) -> CGFloat
    {
        // 1.为了能够调用didSet, 计算配图的高度
        self.status = status
        
        // 2.强制更新界面
        self.layoutIfNeeded();
        
        // 3.返回底部视图最大的Y值
        return footerView.frame.maxY
    }
    
       
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //头部
    public lazy var topView : StatusFooterTopView = StatusFooterTopView();
    
    ///正文 contentLabel
    public lazy var contentLabel : UILabel = {
    
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
    
    /// 底部工具条
    public lazy var footerView: StatusFooterButtonView = {
        
        let view = StatusFooterButtonView();
        view.backgroundColor = UIColor(white: 0.2, alpha: 0.5);
        return view;
    }();

    /// 配图  九宫格
    public lazy var pictureView : StatusPictureCollectionView = {
        
        let view =  StatusPictureCollectionView();
        return view;
    }();
}




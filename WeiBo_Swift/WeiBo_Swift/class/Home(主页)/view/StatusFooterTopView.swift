//
//  StatusFooterTopView.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 2017/1/9.
//  Copyright © 2017年 虞海飞. All rights reserved.
//

import UIKit

class StatusFooterTopView: UIView {

    var status : Status? {
        
        didSet{
            nameLabel.text = status?.user?.name;
            timeLabel.text = status?.created_at;
            sourceLabel.text = "来自: 小霸王学习机";
            //头像  iconView
            if let iconurl = status?.user?.profile_image_url{
                
                let url = URL(string: iconurl);
                iconView.sd_setImage(with: url as URL!);
            }
            
            // 设置认证图标
            verifiedView.image = status?.user?.verifiedImage
        }
    }
    
    /// 添加 view
    private func setupUI(){
        
        addSubview(iconView);
        addSubview(verifiedView);
        addSubview(nameLabel);
        addSubview(vipView);
        addSubview(timeLabel);
        addSubview(sourceLabel);
        
        //头像
        iconView.snp.makeConstraints { (make) in
            
            make.size.equalTo(CGSize(width: 50, height: 50))
            make.top.left.equalTo(10);
        }
        //图标
        verifiedView.snp.makeConstraints { (make) in
            
            make.size.equalTo(CGSize(width: 14, height: 14));
            make.bottom.equalTo(iconView.snp.bottom).offset(5);
            make.right.equalTo(iconView.snp.right).offset(5);
        }
        // 昵称
        nameLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(iconView.snp.top);
            make.left.equalTo(iconView.snp.right).offset(10);
        }
        // vip图标
        vipView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 14, height: 14));
            make.top.equalTo(nameLabel.snp.top);
            make.left.equalTo(nameLabel.snp.right).offset(10);
        }
        //时间
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(10);
            make.left.equalTo(iconView.snp.right).offset(10);
        }
        //来源
        sourceLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(timeLabel.snp.top);
            make.left.equalTo(timeLabel.snp.right).offset(10);
        }
    }
    
    /// 头像
    private lazy var iconView : UIImageView = {
        
        let imageViw = UIImageView(image: UIImage(named: "avatar_default_big"));
        return imageViw;
    }();
    
    /// 图标
    private lazy var verifiedView : UIImageView = {
        
        let imageView = UIImageView(image: UIImage(named: "avatar_enterprise_vip"));
        return imageView;
    }();
    
    /// 昵称
    private lazy var nameLabel : UILabel = {
        
        let label = UILabel();
        label.textColor = UIColor.darkGray;
        //字体的大小
        label.font = UIFont.systemFont(ofSize: 14);
        return label;
    }();
    
    /// 会员图标
    private lazy var vipView : UIImageView = {
        
        let imageView = UIImageView(image: UIImage(named: "common_icon_membership"));
        return imageView;
    }();
    
    ///时间
    private lazy var timeLabel : UILabel = {
        
        let label = UILabel();
        label.textColor = UIColor.darkGray;
        //字体的大小
        label.font = UIFont.systemFont(ofSize: 14);
        return label;
    }();
    ///来源
    private lazy var sourceLabel : UILabel = {
        
        let label = UILabel();
        label.textColor = UIColor.darkGray;
        //字体的大小
        label.font = UIFont.systemFont(ofSize: 14);
        return label;
    }();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        setupUI();
    }
    
  
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

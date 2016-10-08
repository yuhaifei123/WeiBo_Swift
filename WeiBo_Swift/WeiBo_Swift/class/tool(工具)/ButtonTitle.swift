//
//  ButtonTitle.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 16/10/8.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

import UIKit

class ButtonTitle: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame);

        self.setTitleColor(UIColor.darkGray, for: .normal);
        self.setImage(UIImage(named: "navigationbar_arrow_down"), for: UIControlState.normal);
        self.setImage(UIImage(named: "navigationbar_arrow_up"), for: UIControlState.selected);
        self.sizeToFit();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 初始化方法
    override func layoutSubviews() {
        super.layoutSubviews();

        self.titleLabel?.frame.origin.x = 0;
        self.imageView?.frame.origin.x = self.titleLabel!.bounds.size.width;
    }

}

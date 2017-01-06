//
//  Home_TableViewCell.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 2016/12/22.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

import UIKit

class Home_TableViewCell: UITableViewCell {

    let XMGPictureViewCellReuseIdentifier = "XMGPictureViewCellReuseIdentifier";
    
    var status : Status? {
    
        didSet{
            
            nameLabel.text = status?.user?.name;
            timeLabel.text = status?.created_at;
            sourceLabel.text = "来自: 小霸王学习机"
            contentLabel.text = status?.text;
        
            let size = self.calculateImageSize()
            pictureView.snp.updateConstraints { (make) in
                make.size.equalTo(self.calculateImageSize());
              //  make.bottom.equalTo(self.footerView.snp.top).offset(10);
            }
            
            footerView.snp.updateConstraints { (make) in
                make.top.equalTo(pictureView.snp.bottom).offset(10);
            }
            // 1.3设置cell的大小
            pictureLayout.itemSize = CGSize(width: 90, height: 90);
            
            //头像  iconView
            if let iconurl = status?.user?.profile_image_url{
           
                let url = URL(string: iconurl);
                iconView.sd_setImage(with: url as URL!);
            }
            
            // 设置认证图标
            verifiedView.image = status?.user?.verifiedImage
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        setupUI();
        setupPictureView();
    }
    
    // 初始化配图 九宫格
   func setupPictureView(){
    
        // 1.注册cell
        pictureView.register(PictureViewCell.self, forCellWithReuseIdentifier: XMGPictureViewCellReuseIdentifier)
        
        // 2.设置数据源
        pictureView.dataSource = self
        
        // 2.设置cell之间的间隙
        pictureLayout.minimumInteritemSpacing = 10
        pictureLayout.minimumLineSpacing = 10
        
        // 3.设置配图的背景颜色
        pictureView.backgroundColor = UIColor.darkGray
    }
    
    /// 添加 view
    private func setupUI(){
        
        //控制器 view，添加 view
        contentView.addSubview(iconView);
        contentView.addSubview(verifiedView);
        contentView.addSubview(nameLabel);
        contentView.addSubview(vipView);
        contentView.addSubview(timeLabel);
        contentView.addSubview(sourceLabel);
        contentView.addSubview(contentLabel);
        contentView.addSubview(footerView);
        contentView.addSubview(pictureView);
        //view 布局
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
        //正文
        contentLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(iconView.snp.bottom).offset(10);
           // make.bottom.equalTo(footerView.snp.top);
            make.left.equalTo(iconView.snp.left);
            make.bottom.equalTo(pictureView.snp.top).offset(-5)
        }
        
        //配图
        pictureView.snp.makeConstraints { (make) in
            
            //make.top.equalTo(contentLabel.snp.bottom).offset(10);
            make.left.equalTo(10);
            make.size.equalTo(CGSize(width: 1.0, height: 1.0));
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
        self.layoutIfNeeded()
    
        // 3.返回底部视图最大的Y值
        return footerView.frame.maxY
    }
    
    /**
     计算配图的尺寸
     */
    private func calculateImageSize() -> CGSize{
    
        //宽高
        var size : CGSize?;
        //固定宽高
        let width = 90
        let margin = 10
        //那到所有的图片的总数
        let count = status?.storedPicURLS?.count;
        if count == nil || count == 0{
            
            size = CGSize(width: 0, height: 0);
        }
        else if (count == 1){
            //等于1
            //拿到路劲 key
            let key = status?.storedPicURLS?[0].absoluteString;
            //SDWebImageManager.shared().imageCache.imageFromMemoryCache(forKey: <#T##String!#>)
            //拿到 image
            let image = SDWebImageManager.shared().imageCache.imageFromMemoryCache(forKey: key);
                
                  size = image!.size;
        }
        else if (count == 4){
            let viewWidth = width * 2 + margin * 2;
            let viewHeight = width * 2 + margin;
            
            size = CGSize(width: viewWidth, height: viewHeight);
        }
        else{
            
            // 5.1计算列数
            let colNumber = 3
            // 5.2计算行数
            //               (8 - 1) / 3 + 1
            let rowNumber = (count! - 1) / 3 + 1
            // 宽度 = 列数 * 图片的宽度 + (列数 - 1) * 间隙
            let viewWidth = colNumber * width + (colNumber - 1) * margin
            // 高度 = 行数 * 图片的高度 + (行数 - 1) * 间隙
            let viewHeight = rowNumber * width + (rowNumber - 1) * margin
            
            size = CGSize(width: viewWidth, height: viewHeight);
        }
        
        return size!;
    }
    
    /*
     协作一心办实事，
     通达暖心为员工，
     智慧管理真才能，
     联手集体创佳绩！
    */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    ///正文 contentLabel
    private lazy var contentLabel : UILabel = {
    
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
    private lazy var footerView: StatusFooterView = {
        
        let view = StatusFooterView();
        view.backgroundColor = UIColor(white: 0.2, alpha: 0.5);
        return view;
    }();
    
    /// 配图
    private lazy var pictureLayout: UICollectionViewFlowLayout =  UICollectionViewFlowLayout()
    /// 配图  九宫格
    private lazy var pictureView : UICollectionView = {
        
        let view = UICollectionView(frame:CGRect.zero, collectionViewLayout: self.pictureLayout);
        return view;
    }();
}

/// 工具 view
class  StatusFooterView : UIView {
    
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


// MARK: - 九宫格图片
extension Home_TableViewCell : UICollectionViewDataSource{
 
    /// 显示多少图片
    ///
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - section: <#section description#>
    /// - Returns: <#return value description#>
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return status?.storedPicURLS?.count ?? 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 1.取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XMGPictureViewCellReuseIdentifier, for: indexPath) as! PictureViewCell
        // 2.设置数据
        //        cell.backgroundColor = UIColor.greenColor()
        cell.imageURL = status?.storedPicURLS![indexPath.item]
        // 3.返回cell
        return cell
    }
}


/// 设置九宫格的 cell
class PictureViewCell : UICollectionViewCell{
    
    var imageURL : NSURL? {
        
        didSet{
          
           iconImageView.sd_setImage(with: imageURL as! URL)
           // iconImageView(imageURL
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        addView();
    }
    
    /// 添加 view
    private func addView(){
        
        contentView.addSubview(iconImageView);
        iconImageView.snp.makeConstraints { (make) in
            
            make.top.left.bottom.right.equalTo(0);
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var iconImageView : UIImageView = {
    
        let imageView = UIImageView();
        return imageView;
    }();
}

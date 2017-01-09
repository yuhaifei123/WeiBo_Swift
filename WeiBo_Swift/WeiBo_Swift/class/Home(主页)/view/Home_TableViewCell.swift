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
            
            //设置 topview 数据
            topView.status = status;
            contentLabel.text = status?.text;
        
            pictureView.snp.updateConstraints { (make) in
                make.size.equalTo(self.calculateImageSize());
              //  make.bottom.equalTo(self.footerView.snp.top).offset(10);
            }
            
            footerView.snp.updateConstraints { (make) in
                make.top.equalTo(pictureView.snp.bottom).offset(10);
            }
            // 1.3设置cell的大小
            pictureLayout.itemSize = CGSize(width: 90, height: 90);
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
           // make.bottom.equalTo(footerView.snp.top);
            make.left.equalTo(topView.snp.left);
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //头部
    private lazy var topView : StatusFooterTopView = StatusFooterTopView();
    
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
    private lazy var footerView: StatusFooterButtonView = {
        
        let view = StatusFooterButtonView();
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

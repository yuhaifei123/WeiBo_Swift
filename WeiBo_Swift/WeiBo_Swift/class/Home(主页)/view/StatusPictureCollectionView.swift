//
//  StatusPictureCollectionView.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 2017/1/9.
//  Copyright © 2017年 虞海飞. All rights reserved.
//  九宫格，view

import UIKit

class StatusPictureCollectionView: UICollectionView {

    //配置 cell
    let XMGPictureViewCellReuseIdentifier = "XMGPictureViewCellReuseIdentifier";
    /// 配图
    private var pictureLayout: UICollectionViewFlowLayout =  UICollectionViewFlowLayout();
    
    var status : Status? {
        
        didSet{
        
            //有数据 刷新 cell
            reloadData();
        }
    }
    
    /**
     计算配图的尺寸
     */
    public func calculateImageSize() -> CGSize{
        
        //宽高
        var size : CGSize?;
        //固定宽高
        let width = 90
        let margin = 10
        //那到所有的图片的总数
        let count = status?.storedPicURLS?.count;
    
        if count == nil || count == 0{
            
            size = CGSize(width: 0.00001, height: 0.00001);
            pictureLayout.itemSize = size!;
        }
        else if (count == 1){
            //等于1
            //拿到路劲 key
            let key = status?.storedPicURLS?[0].absoluteString;
            //SDWebImageManager.shared().imageCache.imageFromMemoryCache(forKey: <#T##String!#>)
            //拿到 image
            let image = SDWebImageManager.shared().imageCache.imageFromMemoryCache(forKey: key);
            
            size = image!.size;
            pictureLayout.itemSize = size!;
        }
        else if (count == 4){
            let viewWidth = width * 2 + margin * 2;
            let viewHeight = width * 2 + margin;
            
            size = CGSize(width: viewWidth, height: viewHeight);
            pictureLayout.itemSize = CGSize(width: 90, height: 90);
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
            pictureLayout.itemSize = CGSize(width: 90, height: 90);
        }
        
       
        return size!;
    }

    
    /// 初始化 init
    init() {
        super.init(frame: CGRect.zero, collectionViewLayout: pictureLayout);
        
        // 1.注册cell
        self.register(PictureViewCell.self, forCellWithReuseIdentifier: XMGPictureViewCellReuseIdentifier)
        
        // 2.设置数据源
        self.dataSource = self
        
        // 2.设置cell之间的间隙
        pictureLayout.minimumInteritemSpacing = 10
        pictureLayout.minimumLineSpacing = 10
        
        // 3.设置配图的背景颜色
        self.backgroundColor = UIColor.darkGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 九宫格图片
extension StatusPictureCollectionView : UICollectionViewDataSource{
    
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
private class PictureViewCell : UICollectionViewCell{
    
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



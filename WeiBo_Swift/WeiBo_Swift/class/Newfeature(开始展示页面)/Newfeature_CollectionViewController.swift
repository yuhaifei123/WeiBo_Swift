//
//  Newfeature_CollectionViewController.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 2016/12/20.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

import UIKit


/// cell 的唯一 id
private let reuseIdentifier = "reuseIdentifier"
/// 多少页面
private let cellIndex : Int = 4;

class Newfeature_CollectionViewController: UICollectionViewController {
    
    private let layout = Newfeature_CollectionViewController_Layout();
    
    
    /// 初始化布局大小，因为 CollectionViewController 初始化是调用这个init(collectionViewLayout: layout!)方法
    /// 所以这里不要继承
    init() {
        super.init(collectionViewLayout: layout);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 注册一个 cell 这个是UICollectionViewController 必须的事情
        self.collectionView!.register(Newfeature_CollectionViewController_Cell.self, forCellWithReuseIdentifier: reuseIdentifier);
    }

    
    /// 将要展示页面
    ///
    /// - Parameter animated: <#animated description#>
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
    }

    // MARK: UICollectionViewDataSource
    
    /// 显示多少组 默认是 1
    ///
    /// - Parameter collectionView: <#collectionView description#>
    /// - Returns: <#return value description#>
    /*
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }
 */
    
    /// 一组显示多少个
    ///
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - section: <#section description#>
    /// - Returns: <#return value description#>
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return cellIndex;
    }

    
    /// 显示 cell
    ///
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - indexPath: <#indexPath description#>
    /// - Returns: <#return value description#>
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //默认拿去 cell
        let cell : Newfeature_CollectionViewController_Cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! Newfeature_CollectionViewController_Cell;
        cell.imgeIndex = indexPath.item;
        return cell
    }
}


/// 设置 cell
class Newfeature_CollectionViewController_Cell : UICollectionViewCell{
    
     var imgeIndex : Int? {
        
        didSet{
            
            iconView.image = UIImage(named: "new_feature_\(imgeIndex! + 1)");
        }
    }
  
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 1.初始化UI
        setupUI();
    }
    
    
    /// 初始化UI
    private func setupUI(){
        
        //用这个 view，不加进去的话，有时候是控制器 view 的改变，他不改变，比如，uitaleview 中删除单行
        contentView.addSubview(iconView);
        // 2.布局子控件的位置
        iconView.xmg_Fill(contentView);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
  // private let iconView = UIImageView();
    private lazy var iconView = UIImageView();
}

/// 设置内部方法，来设置 Layout
class Newfeature_CollectionViewController_Layout : UICollectionViewFlowLayout {
    
    
     /// 这个是，CollectionView 先调用  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)，判断有多少 cell，
    ///然后调用这个方法，来设置 layout 的大小，
    ///在调用collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)方法
     override func prepare() {
        
        // 设置这个cell 的大小
        itemSize = UIScreen.main.bounds.size;
        //设置 cell 之间的左右的间距为0
        minimumInteritemSpacing = 0;
        //设置 cell 高的之间距为0
        minimumLineSpacing = 0;
        //水平翻页
        scrollDirection = UICollectionViewScrollDirection.horizontal;
        
        //不显示，水平滚动条
        collectionView?.showsHorizontalScrollIndicator = false;
        //不要有拖动回弹动画
        collectionView?.bounces = false;
        //分页
        collectionView?.isPagingEnabled = true;
    }
}

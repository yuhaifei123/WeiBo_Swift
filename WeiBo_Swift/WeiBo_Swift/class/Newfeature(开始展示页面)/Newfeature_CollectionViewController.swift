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
    
    
    /// 完全显示一个cell之后调用
    ///
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - cell: <#cell description#>
    ///   - indexPath: <#indexPath description#>
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        // 1.拿到当前显示的cell对应的索引
        let path = collectionView.indexPathsForVisibleItems.last!;
        let  cell : Newfeature_CollectionViewController_Cell = collectionView.cellForItem(at: path) as! Newfeature_CollectionViewController_Cell;
        
        if path.item == (cellIndex - 1) {
           
            cell.loginButton.isHidden = false;
            cell.startBtnAnimation();
           
            return;
        }
        
        cell.loginButton.isHidden = true;
    }
}


/// 设置 cell
///// 如果当前类需要监听按钮的点击方法, 那么当前类不是是私有的
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 点击登录按钮触发事件
    func clickLoginButton(){
        
        print("点击我干嘛")
    };
    
    /// 初始化UI
    private func setupUI(){
        
        //用这个 view，不加进去的话，有时候是控制器 view 的改变，他不改变，比如，uitaleview 中删除单行
        contentView.addSubview(iconView);
        contentView.addSubview(loginButton);
        // 2.布局子控件的位置
        iconView.xmg_Fill(contentView);
        loginButton.xmg_AlignInner(type: XMG_AlignType.bottomCenter, referView: contentView, size: nil, offset: CGPoint(x: 0, y: -160));
    }
    
    
    /// button 的动画，一点点变大的动画
    public func startBtnAnimation(){
    
        // 执行动画(默认是啥也没有的) 变形
        loginButton.transform = CGAffineTransform(scaleX: 0.0, y: 0.0);
        //不能有触发事件
        loginButton.isUserInteractionEnabled = false;
        // withDuration 时间，delay 延时，options： 选择枚举，啥动画，usingSpringWithDamping: 放大效果（1.0 最小），options：放大的速度（速度越大，动画幅度越大）
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
            () -> Void in
            
            //回到默认的大小 CGAffineTransform 变形
            self.loginButton.transform = CGAffineTransform.identity;
            
        }, completion: {
            (Bool) -> Void in
            self.loginButton.isUserInteractionEnabled = true;
        });
    }

    
  // private let iconView = UIImageView();
    private lazy var iconView = UIImageView();
    
    public lazy var loginButton : UIButton = {
        
        let button = UIButton();
        button.setBackgroundImage(UIImage(named: "new_feature_button"), for: UIControlState());
        button.setBackgroundImage(UIImage(named: "new_feature_button_highlighted"), for: UIControlState.highlighted);
        button.isHidden = true;
        button.addTarget(self, action: #selector(Newfeature_CollectionViewController_Cell.clickLoginButton), for: UIControlEvents.touchUpInside);
        
        return button;
    }();
    
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

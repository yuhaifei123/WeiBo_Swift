//
//  Home_TableViewController.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 16/8/15.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

import UIKit

class Home_TableViewController: All_TableViewController {

    let HomeReuseIdentifier = "HomeReuseIdentifier";
    
    /// tableView Cell 数据
    var arrray_Status : [Status]? {
        // 当 arrray_Status 有值后，就调用此方法
        didSet{
            tableView.reloadData();
        }
    }
    
    //标题 button
    let titleButton = ButtonTitle();
    var isOpen : Bool = AccessToken_Model.userLogin();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isLogin == false {

            visitorView?.setupVisitorView(ishome: true, imageName: "visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜");
            return;
        }
        
            navButton();
        
        /// 接受广播
        let notName = NSNotification.Name(rawValue:"notifyChatMsgRecv");
        NotificationCenter.default.addObserver(self, selector: #selector(self.radioClass(notification:)), name: notName, object: nil);
        
        // 注册一个cell
    
        tableView.register(Home_TableViewCell.self, forCellReuseIdentifier: HomeReuseIdentifier);
        //不要 uiviewcell 的分割线
        tableView.separatorStyle  = UITableViewCellSeparatorStyle.none;

    }
    
    /// 页面加载时，加载数据
    ///
    /// - Parameter animated: <#animated description#>
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    
        if tableView == nil{
            print("adsfdsf");
        }
              //默认 uiviewCell 的 高度是200
        //tableView.estimatedRowHeight = 200
        //uiviewCell 高度可以动态
        //tableView.rowHeight = UITableViewAutomaticDimension;
     
        
        // 4.加载微博数据
        loadData()
    }
    
    /// 接受广播方法
    ///
    /// - Parameter notification: <#notification description#>
    func radioClass(notification : Notification){
        
        let dic = notification.userInfo;
        if let dic_un = dic{
            
            let isSelect = dic_un["state"] as! Bool;
            titleButton.isSelected = isSelect;
        }
    }

    /// 加载微博数据
    func loadData(){
        
        Status.loadStatuses { (any, error) in
            
            if error != nil{
                return;
            }
            self.arrray_Status = any;
        }
    }
    
    ///登陆成功了，就是设置navitem的按钮
    private func navButton(){

       //设置控制器，左右
        navigationItem.leftBarButtonItem =  UIBarButtonItem.ItemBut(imageNameN: "navigationbar_friendattention", target: self, action: #selector(self.leftBtnClick));

        navigationItem.rightBarButtonItem = UIBarButtonItem.ItemBut(imageNameN: "navigationbar_pop", target: self, action: #selector(self.rightButClick));

        titleButton.setTitle("微博 daemo ", for: UIControlState.normal);
               titleButton.addTarget(self, action: #selector(self.titeButton(btn:)), for: UIControlEvents.touchUpInside);

        navigationItem.titleView = titleButton;
    }

    
    /// 点击 button 后触发事件
    ///
    /// - Parameter btn: <#btn description#>
    func titeButton(btn : UIButton){
        
        //按钮状态改变
        btn.isSelected = !btn.isSelected;
        
        let vc = UIStoryboard(name: "PopSB", bundle: nil);
        let cn : UIViewController = vc.instantiateInitialViewController()!;
        //设置转场动画代理
        //如果，用默认的 modal，会把以前的控制器移除。
        //有自定义，就不会，会有两个控制器
        cn.transitioningDelegate = popController;
        //设置转场动画样式
        cn.modalPresentationStyle = UIModalPresentationStyle.custom;
        //转场方式
        self.present(cn, animated: true, completion: nil);
    }

    
    /// 点击左边按钮
    func  leftBtnClick(){

        print("aaaa");
    }
    
    /// 右边 button + 
    func rightButClick(){

        let sb = UIStoryboard(name: "QrCode", bundle: nil);
        let controller = sb.instantiateInitialViewController();
        self.present(controller!, animated: true, completion: nil);
    }
    
    
    lazy var popController : Poptroller_Object = {
        
        let pop = Poptroller_Object();
        return pop;
    }();
    
    /// 微博行高的缓存, 利用字典作为容器. key就是微博的id, 值就是对应微博的行高
    var rowCache: [Int: CGFloat] = [Int: CGFloat]()
    
    override func didReceiveMemoryWarning() {
        // 清空缓存
        rowCache.removeAll()
    }
}


// MARK: - uitableView 属性
extension Home_TableViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrray_Status?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        // 1.获取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeReuseIdentifier, for: indexPath) as! Home_TableViewCell
        // 2.设置数据
        let status = arrray_Status![indexPath.row];
        print(status.storedPicURLS);
        cell.status = status;
        // 3.返回cell
        return cell
    }
    
      override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 1.取出对应行的模型
        let status = arrray_Status![indexPath.row]
        
        // 2.判断缓存中有没有
        if let height = rowCache[status.id]
        {
            print("从缓存中获取")
            return height
        }
        
        // 3.拿到cell
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeReuseIdentifier) as! Home_TableViewCell
        // 注意点:不要使用以下方法获取, 在某些版本或者模拟器会有bug
        //        tableView.dequeueReusableCellWithIdentifier(<#T##identifier: String##String#>, forIndexPath: <#T##NSIndexPath#>)
        
        // 4.拿到对应行的行高
        let rowHeight = cell.rowHeight(status: status)
        
        // 5.缓存行高
        rowCache[status.id] = rowHeight
        
        // 6.返回行高
        return rowHeight
    }

}


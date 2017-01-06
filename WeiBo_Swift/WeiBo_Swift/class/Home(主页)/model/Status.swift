//
//  Status.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 2016/12/21.
//  Copyright © 2016年 虞海飞. All rights reserved.
//  请求微博详细数据

import UIKit

class Status: NSObject{

    /// 微博创建时间
    var created_at: String?{
        didSet{
            // 1.将字符串转换为时间
            let createdDate = NSDate.dateWithStr(time: created_at!);
            // 2.获取格式化之后的时间字符串
            created_at = createdDate.descDate;
        }
    }
    /// 微博ID
    var id: Int = 0
    /// 微博信息内容
    var text: String?
    /// 微博来源
    var source: String?
    /// 配图数组
    var pic_urls: [[String: AnyObject]]? {
        
        didSet{
            // 1.初始化数组
            storedPicURLS = [NSURL]()
            // 2遍历取出所有的图片路径字符串
            for dict in pic_urls!{
                if let urlStr = dict["thumbnail_pic"]{
                    // 将字符串转换为URL保存到数组中
                    storedPicURLS?.append(NSURL(string: urlStr as! String)!)
                }
            }
        }
    }
    
    /// 保存当前微博所有配图的URL
    var storedPicURLS: [NSURL]?
    
    var user : User?;
    
    override init() {
        super.init();
    }

    /// 获取数据
    ///
    /// - Parameter dic: <#dic description#>
    init(dic: [String : AnyObject]){
        super.init();
        
        //kvc 方法 必须要  super.init();
        setValuesForKeys(dic)
    }
    
    
    ///  setValuesForKeys内部会调用以下方法
    ///
    /// - Parameters:
    ///   - value: <#value description#>
    ///   - key: <#key description#>
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "user" {
           user = User(dic: (value as! [String : AnyObject]));
           return;
        }
        super.setValue(value, forKey: key);
    }
    
    /// 用 kvc 时，如果没有数据，会报错，从写方法
    ///
    /// - Parameters:
    ///   - value: <#value description#>
    ///   - key: <#key description#>
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
       
    }
    
    /// 打印 model 对象
    let dicdescription = ["created_at", "id", "text", "source", "pic_urls"];
    override var description: String {
        
        let dic = self.dictionaryWithValues(forKeys: dicdescription);
        return "\(dic)";
    }
    
    
    /// 请求网络数据
    ///
    /// - Parameter finished: models ： 数据 ， error ； 错误信息
   class func loadStatuses(finished: @escaping (_ models:[Status]?, _ error : Error?) ->()){
        
        let path = "2/statuses/home_timeline.json"
        let params = ["access_token": AccessToken_Model.loadAccessToken()?.access_token];
        AFNetworkTools.shareNetwork().get(path, parameters: params, progress: {
            (_) -> Void in
        }, success: {
            (_, JSON) -> Void in

            let dic = JSON as! [String : AnyObject];
           
            let array : [[String:AnyObject]] = dic["statuses"] as! [[String : AnyObject]];
            let models =  self.dict2Model(list: array);
            cacheStatusImages(list: models, finished: finished);
            return;
        }, failure: {
            (_, Error) -> Void in
            finished(nil,Error);
        });
    }
    
    ///  缓存图片 
    ///
    /// - Parameters:
    ///   - list: <#list description#>
    ///   - finished: <#finished description#>
    class func cacheStatusImages(list: [Status], finished: @escaping (_ models:[Status]?, _ error:NSError?)->()) {
    
        //创建一个组（线程组）
        let group = DispatchGroup();

        for status in  list {
            
            if status.storedPicURLS == nil{
                
                continue;
            }
            
            for url in status.storedPicURLS! {
                
                // 将当前的下载操作添加到组中
                group.enter()
                
                // 缓存图片
                SDWebImageManager.shared().downloadImage(with: url as URL!, options: SDWebImageOptions(rawValue: 0), progress: nil, completed: { (_, _, _, _, _) -> Void in
                // 离开当前组
                group.leave();
                });
            }
            
        }
       
        // 2.当所有图片都下载完毕再通过闭包通知调用者
       // dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
            // 能够来到这个地方, 一定是所有图片都下载完毕
         //  finished(list, nil);
        //}
        //finished(list, nil);
       group.notify(queue: DispatchQueue.main) { 
         finished(list, nil);
        }
    }
    
    /// 解析网络返回数据
    ///
    /// - Parameter dic: <#dic description#>
   class func dict2Model (list : [[String: AnyObject]]) -> [Status]{
        
        var array_model : Array<Status> = Array<Status>();
        for dict : [String: AnyObject] in list {
            
            array_model.append(Status.init(dic: dict));
        }
        
        //print(array_model[0])
        return array_model;
    }
}

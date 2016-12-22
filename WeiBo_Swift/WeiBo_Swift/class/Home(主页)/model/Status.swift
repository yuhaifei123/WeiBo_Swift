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
    var created_at: String?
    /// 微博ID
    var id: Int = 0
    /// 微博信息内容
    var text: String?
    /// 微博来源
    var source: String?
    /// 配图数组
    var pic_urls: [[String: AnyObject]]?
    var user : User?;
    
    override init() {
        super.init();
    }

    /// 获取数据
    ///
    /// - Parameter dic: <#dic description#>
    init(dic: [String : AnyObject]){
        super.init();
        
        /*
        created_at = dic["created_at"] as! String?;
        id = dic["id"] as! Int;
        text = dic["text"] as! String?;
        source = dic["source"] as! String?;
        pic_urls = dic["pic_urls"] as! [[String : AnyObject]]?;
 */
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
    func loadStatuses(finished: @escaping (_ models:[Status]?, _ error : Error?) ->()){
        
        let path = "2/statuses/home_timeline.json"
        let params = ["access_token": AccessToken_Model.loadAccessToken()?.access_token];
        AFNetworkTools.shareNetwork().get(path, parameters: params, progress: {
            (_) -> Void in
        }, success: {
            (_, JSON) -> Void in

            let dic = JSON as! [String : AnyObject];
           
            let array : [[String:AnyObject]] = dic["statuses"] as! [[String : AnyObject]];
            //self.dict2Model(list: array);
            finished(self.dict2Model(list: array), nil);
            return;
        }, failure: {
            (_, Error) -> Void in
            finished(nil,Error);
        });
    }

    /// 解析网络返回数据
    ///
    /// - Parameter dic: <#dic description#>
    func dict2Model (list : [[String: AnyObject]]) -> [Status]{
        
        var array_model : Array<Status> = Array<Status>();
        for dict : [String: AnyObject] in list {
            
            array_model.append(Status.init(dic: dict));
        }
        
        //print(array_model[0])
        return array_model;
    }
}

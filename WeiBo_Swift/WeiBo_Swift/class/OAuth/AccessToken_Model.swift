//
//  AccessToken_Model.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 2016/12/16.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

import UIKit


/// NSCoding 归档方法，
class AccessToken_Model: NSObject, NSCoding{
  
    var access_token : String?;
    var uid : String?;
    var expires_in : NSNumber?;
    //保存用户的过期时间
    var expires_Date : NSDate?
    
    init(dic : [String : AnyObject]) {
        
        access_token = dic["access_token"] as! String?;
        expires_in = dic["expires_in"] as! NSNumber?;
        uid = dic["uid"] as! String?;
        expires_Date = NSDate(timeIntervalSinceNow: (expires_in?.doubleValue)!);
        
    }
    
    
    /// 默认打印数据，描述数据,其他类里面要打印这个对象，就会显示出来
    override var description: String{
        
        let properties : Array<String> = ["access_token","expires_in","uid","expires_Date"];
        let dic = self.dictionaryWithValues(forKeys: properties);
        return "\(dic)";
    }
    
    /// 判断用户是不是登录
    ///
    /// - Returns: <#return value description#>
    class func userLogin() -> Bool{
        
        var bool_user : Bool = false;
        if AccessToken_Model.loadAccessToken() != nil {
            
            bool_user = true;
        }
        
        return bool_user;
    }
    
    /// 添加数据到，归档里面去
    public func saveAccessToken(){
        
        //得到系统路径
        let string_path : String = "account.plist";
        let string_FilePath : String = string_path.cacheDir();
        
        print("\(string_FilePath)");
        NSKeyedArchiver.archiveRootObject(self, toFile: string_FilePath);
    }

    static var account : AccessToken_Model?;
    /// 从归档里面拿数据
    ///
    /// - Returns: <#return value description#>
    class func loadAccessToken () -> AccessToken_Model?{
        
        //如果这个数据加载过，就不去请求数据
        if account != nil {
            
            return account;
        }
        
        //得到系统路径
        let string_path : String = "account.plist";
        let string_FilePath : String = string_path.cacheDir();
        
        print("\(string_FilePath)");
        //到这个路径里面去拿数据
         account = NSKeyedUnarchiver.unarchiveObject(withFile: string_FilePath) as? AccessToken_Model;
        
        //过期了判断
        if account?.expires_Date?.compare(account?.newDate as! Date) == ComparisonResult.orderedAscending{
            
            //过期了
            return nil;
        }
        
        return account;
    }
        
    /// MARK - 归档的方法 接口
    /// 将对象写入到对象中
    ///
    /// - Parameter aCoder: <#aCoder description#>
    
    public func encode(with aCoder: NSCoder){
        
        aCoder.encode(access_token, forKey: "access_token");
        aCoder.encode(expires_in, forKey: "expires_in");
        aCoder.encode(uid, forKey: "uid");
        aCoder.encode(expires_Date, forKey: "expires_Date")
    }
    
    //// 从文件中读取对象
    required init?(coder aDecoder: NSCoder) {
        
        access_token = aDecoder.decodeObject(forKey: "access_token") as! String?;
        expires_in = aDecoder.decodeObject(forKey: "expires_in") as! NSNumber?;
        uid = aDecoder.decodeObject(forKey: "uid") as! String?;
        expires_Date = aDecoder.decodeObject(forKey: "expires_Date") as! NSDate?;
    }

    private lazy var newDate : NSDate = NSDate();
 }



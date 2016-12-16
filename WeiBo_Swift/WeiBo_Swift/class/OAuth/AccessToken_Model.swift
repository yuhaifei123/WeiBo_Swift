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
    var expires_in : NSNumber?;
    var uid : String?;
    
    init(dic : [String : AnyObject]) {
        access_token = dic["access_token"] as! String?;
        expires_in = dic["expires_in"] as! NSNumber?;
        uid = dic["uid"] as! String?;
    }
    
    override var description: String{
        
        let properties : Array<String> = ["access_token","expires_in","uid"];
        let dic = self.dictionaryWithValues(forKeys: properties);
        return "\(dic)";
    }
    

    
    /// 添加数据到，归档里面去
    public func saveAccessToken(){
        
        //得到系统路径
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last;
        let string_path : String = path!;
        let string_FilePath : String = string_path + "account.plist";
        
        print("\(string_FilePath)");
        NSKeyedArchiver.archiveRootObject(self, toFile: string_FilePath);
    }

    /// 从归档里面拿数据
    ///
    /// - Returns: <#return value description#>
    class func loadAccessToken () -> AccessToken_Model?{
        
        //得到系统路径
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last;
        let string_path : String = path!;
        let string_FilePath : String = string_path + "account.plist";
        
        print("\(string_FilePath)");
        
        //到这个路径里面去拿数据
        let account = NSKeyedUnarchiver.unarchiveObject(withFile: string_FilePath) as? AccessToken_Model;
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
    }
    
    //// 从文件中读取对象
    required init?(coder aDecoder: NSCoder) {
        
        access_token = aDecoder.decodeObject(forKey: "access_token") as! String?;
        expires_in = aDecoder.decodeObject(forKey: "expires_in") as! NSNumber?;
        uid = aDecoder.decodeObject(forKey: "uid") as! String?;
    }

 }



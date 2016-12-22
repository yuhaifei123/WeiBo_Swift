//
//  User.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 2016/12/22.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

import UIKit

class User: NSObject {

    /// 用户ID
    var id: Int = 0
    /// 友好显示名称
    var name: String?
    /// 用户头像地址（中图），50×50像素
    var profile_image_url: String?
    /// 时候是认证, true是, false不是
    var verified: Bool = false
    /// 用户的认证类型，-1：没有认证，0，认证用户，2,3,5: 企业认证，220: 达人
    var verified_type: Int = -1

    
    init(dic : [String : AnyObject]) {
        super.init();
        
        id = dic["id"] as! Int;
        name = dic["name"] as? String;
        profile_image_url = dic["profile_image_url"] as! String?
        verified = (dic["verified"] != nil)
        verified_type = dic["verified_type"] as! Int
 
        
       // setValuesForKeys(dic);
    }
    
    
    
    ///  防止setValuesForKeys 有一些属性没有数据，报错，只要重写这个方法就可以
    /// - Parameters:
    ///   - value: <#value description#>
    ///   - key: <#key description#>
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    /// setValuesForKeys内部会调用以下方法
    ///
    /// - Parameters:
    ///   - value: <#value description#>
    ///   - key: <#key description#>
    override func setValue(_ value: Any?, forKey key: String) {
        
    }
    
    /// 这个是调用，model 是打印数据
    let dicdescription = ["id", "name", "profile_image_url", "verified", "verified_type"];
    override var description: String{
        
        let dic = self.dictionaryWithValues(forKeys: dicdescription);
        return "\(dic)";
    }
}

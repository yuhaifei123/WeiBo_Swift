//
//  AFNetworkTools.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 2016/12/16.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

import UIKit

class AFNetworkTools: AFHTTPSessionManager {

    static let Network : AFNetworkTools = {
    
        let url = NSURL(string:"https://api.weibo.com/");
        let t = AFNetworkTools(baseURL: url as URL?);
        t.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript","text/plain") as? Set<String>;
        return t;
    }();
    
    class func shareNetwork () -> AFNetworkTools{
        
        return Network;
    }
}

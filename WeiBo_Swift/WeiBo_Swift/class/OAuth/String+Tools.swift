//
//  String+Tools.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 2016/12/19.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

import Foundation

extension String {
    
    
    /// 将当前字符串拼接到cache目录的后面
    ///
    /// - Returns: 拼接后的路径
    func  cacheDir () -> String {
        
        let path  =  NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last;
        
        var nsstring_path : NSString = "";
        //强行拆包
        if let string_path = path{
            
            nsstring_path =  string_path as NSString;
            //得到有效的地址"www.baidu.com/aa.plst" 得到 aa.plst
            return nsstring_path.appendingPathComponent(self);
        }
        
        return nsstring_path as String;
    }
    
    
    
    /// 将当前字符串拼接到cache目录的后面
    ///
    /// - Returns: 拼接后的路径
    func docDir() -> String{
        
        let path  =  NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last;
        
        var nsstring_path : NSString = "";
         //强行拆包
        if let string_path = path{
            
            nsstring_path = string_path as NSString;
            //得到有效的地址"www.baidu.com/aa.plst" 得到 aa.plst
            return nsstring_path.appendingPathComponent(self);
        }
        
        return nsstring_path as String;
    }
    
    /// 将当前字符串拼接到tmp目录的后面
    ///
    /// - Returns: 拼接后的路径
    func tmpDir() -> String{
        
        var nsstring_path : NSString = "";
        
        let path : String =  NSTemporaryDirectory();
        nsstring_path = path as NSString;

        return nsstring_path.appendingPathComponent(self);
    }
    
}

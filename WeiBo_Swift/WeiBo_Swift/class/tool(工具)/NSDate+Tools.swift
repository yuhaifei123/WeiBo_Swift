//
//  NSDate+Tools.swift
//  WeiBo_Swift
//
//  Created by 虞海飞 on 2016/12/23.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

import UIKit

extension NSDate{
    
    class func dateWithStr(time: String) ->NSDate {
        
        // 1.将服务器返回给我们的时间字符串转换为NSDate
        // 1.1.创建formatter
        let formatter = DateFormatter()
        // 1.2.设置时间的格式
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z yyyy"
        // 1.3设置时间的区域(真机必须设置, 否则可能不能转换成功)
        formatter.locale = NSLocale(localeIdentifier: "en") as Locale!
        // 1.4转换字符串, 转换好的时间是去除时区的时间
        let createdDate = formatter.date(from: time)!
      //  formatter.string(from: createdDate);
        
        return createdDate as NSDate
    }
    
    /**
     刚刚(一分钟内)
     X分钟前(一小时内)
     X小时前(当天)
     昨天 HH:mm(昨天)
     MM-dd HH:mm(一年内)
     yyyy-MM-dd HH:mm(更早期)
     */
    var descDate:String{
        
        let calendar = NSCalendar.current
        
        // 1.判断是否是今天
        if calendar.isDateInToday(self as Date)
        {
            // 1.0获取当前时间和系统时间之间的差距(秒数)
            let since = Int(NSDate().timeIntervalSince(self as Date))

            // 1.1是否是刚刚
            if since < 60
            {
                return "刚刚"
            }
            // 1.2多少分钟以前
            if since < 60 * 60
            {
                return "\(since/60)分钟前"
            }
            
            // 1.3多少小时以前
            return "\(since / (60 * 60))小时前"
        }
        
        // 2.判断是否是昨天
        var formatterStr = "HH:mm"
        if calendar.isDateInYesterday(self as Date)
        {
            // 昨天: HH:mm
            formatterStr =  "昨天:" +  formatterStr
        }else
        {
            // 3.处理一年以内
            formatterStr = "MM-dd " + formatterStr
            
        }
        
        // 5.按照指定的格式将时间转换为字符串
        // 5.1.创建formatter
        let formatter = DateFormatter()
        // 5.2.设置时间的格式
        formatter.dateFormat = formatterStr
        // 5.3设置时间的区域(真机必须设置, 否则可能不能转换成功)
        formatter.locale = NSLocale(localeIdentifier: "en") as Locale!
        // 5.4格式化
        
        return formatter.string(from: self as Date)
    }

    
  }

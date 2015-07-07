//
//  NetWork.swift
//  TestHttp
//
//  Created by 大可立青 on 15/7/7.
//  Copyright © 2015年 大可立青. All rights reserved.
//

import Foundation

class NetWork{
    static func request (method: String, url: String, params: [String:AnyObject]? = nil, callback: (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void){
        let manager = NetworkManager(url: url, method: method, params: params, callback: callback)
        manager.fire()
    }

    //不带params的接口
    static func request(method:String,url:String,callback:(data: NSData!, response: NSURLResponse!, error: NSError!) -> Void){
        let manager = NetworkManager(url: url, method: method, callback: callback)
        manager.fire()
    }
    
    //带params的get接口
    static func get(url: String, params: [String:AnyObject]? = nil, callback: (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void){
        let manager = NetworkManager(url: url, method: "GET", params: params, callback: callback)
        manager.fire()
    }
    
    //不带params的get接口
    static func get(url: String,callback: (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void){
        let manager = NetworkManager(url: url, method: "GET",callback: callback)
        manager.fire()
    }
    
    //带params的post接口
    static func post(url: String, params: [String:AnyObject]? = nil, callback: (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void){
        let manager = NetworkManager(url: url, method: "POST", params: params, callback: callback)
        manager.fire()
    }
    
    //不带params的post接口
    static func post(url: String,callback: (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void){
        let manager = NetworkManager(url: url, method: "POST",callback: callback)
        manager.fire()
    }
}
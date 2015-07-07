//
//  NetworkManager.swift
//  TestHttp
//
//  Created by 大可立青 on 15/7/7.
//  Copyright © 2015年 大可立青. All rights reserved.
//

import Foundation

class NetworkManager{
    let method:String!
    let params:[String:AnyObject]!
    let callback:(data:NSData!,response:NSURLResponse!,error:NSError!)->Void
    let session = NSURLSession.sharedSession()
    let url: String!
    var request: NSMutableURLRequest!
    var task: NSURLSessionTask!
    
    init(url: String, method: String, params: [String:AnyObject]? = nil, callback: (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void) {
        self.url = url
        self.request = NSMutableURLRequest(URL: NSURL(string: url)!)
        self.method = method
        self.params = params
        self.callback = callback
    }
    
    func buildRequest() {
        if self.method == "GET" && self.params.count > 0 {
        self.request = NSMutableURLRequest(URL: NSURL(string: url + "?" + query(self.params))!)
        }
        
        request.HTTPMethod = self.method
        
        if self.params.count > 0 {
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
    }
    func buildBody() {
        if self.params.count > 0 && self.method != "GET" {
        request.HTTPBody = query(self.params) as? NSData
        }
    }
    func fireTask() {
        task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
        self.callback(data: data, response: response, error: error)
        })
        task.resume()
    }
    
    //Alamofire的三个函数
    func query(parameters: [String: AnyObject]) -> String {
        var components: [(String, String)] = []
        for key in Array(parameters.keys).sort(<) {
            let value: AnyObject! = parameters[key]
            components += self.queryComponents(key, value)
        }
        
        return "&".join(components.map{"\($0)=\($1)"} as [String])
    }
    
    func queryComponents(key: String, _ value: AnyObject) -> [(String, String)] {
            var components: [(String, String)] = []
            if let dictionary = value as? [String: AnyObject] {
            for (nestedKey, value) in dictionary {
            components += queryComponents("\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [AnyObject] {
            for value in array {
            components += queryComponents("\(key)[]", value)
            }
        } else {
            components.extend([(escape(key), escape("\(value)"))])
            }
            
            return components
    }
    func escape(string: String) -> String {
            let legalURLCharactersToBeEscaped: CFStringRef = ":&=;+!@#$()',*"
            return CFURLCreateStringByAddingPercentEscapes(nil, string, nil, legalURLCharactersToBeEscaped, CFStringBuiltInEncodings.UTF8.rawValue) as String
    }
    
    //统一
    func fire() {
        buildRequest()
        buildBody()
        fireTask()
    }

}

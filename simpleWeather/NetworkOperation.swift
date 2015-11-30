//
//  NetworkOperation.swift
//  simpleWeather
//
//  Created by 刘卫斌 on 15/11/28.
//  Copyright © 2015年 yufu. All rights reserved.
//

import Foundation

class NetworkOperation {
    
    let queryURL:NSURL
    init(url:NSURL){
        queryURL = url
    }
    
    func downloadJsonFromURL(conpletion:([String:AnyObject])->Void){
        
        let config:NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let request = NSURLRequest(URL: self.queryURL)
        let dataTask = session.dataTaskWithRequest(request){
            (let data,let response,let error) in
            
            let jsonDictionary = try? NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:AnyObject]
            //print(jsonDictionary)
            conpletion(jsonDictionary!!)
        }
        
        dataTask.resume()
    }
}
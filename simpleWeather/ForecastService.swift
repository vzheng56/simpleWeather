//
//  ForecastService.swift
//  simpleWeather
//
//  Created by 刘卫斌 on 15/11/28.
//  Copyright © 2015年 yufu. All rights reserved.
//

import Foundation

protocol ForecastDelegate{
    func GetCurrentWeather(weather:CurrentWeather?)
}

struct ForecastService {
    let forecastAPIKey:String
    let forcastBaseURL:NSURL?
    var delegate:ForecastDelegate?
    
    init(APIKey:String){
        forecastAPIKey = APIKey
        forcastBaseURL = NSURL(string: "https://api.darksky.net/forecast/\(forecastAPIKey)/")
    }
    
    
    func getForecast(lat:Double,lon:Double,completion:(CurrentWeather?->Void)){
        
        if let forecastURL = NSURL(string: "\(lat),\(lon)", relativeToURL: forcastBaseURL) {
            let networkOperation = NetworkOperation(url: forecastURL)
            networkOperation.downloadJsonFromURL(){
                (let JSONDictionary) in
                
                if let currentWeather:CurrentWeather = self.currentWeatherFromJSONDictionary(JSONDictionary){
                    completion(currentWeather)
                }
            
            }
        }
    }
    
    func getForecast(lat:Double,lon:Double){
        
        if let forecastURL = NSURL(string: "\(lat),\(lon)", relativeToURL: forcastBaseURL) {
            let networkOperation = NetworkOperation(url: forecastURL)
            networkOperation.downloadJsonFromURL(){
                (let JSONDictionary) in
                
                if let currentWeather:CurrentWeather = self.currentWeatherFromJSONDictionary(JSONDictionary){
                    self.delegate?.GetCurrentWeather(currentWeather)
                }
                
            }
        }
    }
    
    
    
    func currentWeatherFromJSONDictionary(jsonDictionary:[String:AnyObject])->CurrentWeather?{
        if let currentWeatherDictionary = jsonDictionary["currently"] as? [String:AnyObject]{
            return CurrentWeather(weatherDictionary: currentWeatherDictionary)
        }else{
            print("JSON dictionary return nil!!!")
            return nil
        }
        
    }
}

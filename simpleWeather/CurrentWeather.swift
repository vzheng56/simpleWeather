//
//  CurrentWeather.swift
//  simpleWeather
//
//  Created by 刘卫斌 on 15/11/26.
//  Copyright © 2015年 yufu. All rights reserved.
//

import Foundation
import UIKit

enum Icon:String{
    
    case ClearDay = "clear-day"
    case ClearNight = "clear-night"
    case Rain = "rain"
    case Snow = "snow"
    case Sleet = "sleet"
    case Wind = "wind"
    case Fog = "fog"
    case Cloudy = "cloudy"
    case PartlyCloudyDay = "partly-cloudy-day"
    case PartlyCloudyNight = "partly-cloudy-night"
    
    
    func toImage() -> UIImage? {
        var imageName: String
        
        switch self {
        case .ClearDay:
            imageName = "clear-day.png"
        case .ClearNight:
            imageName = "clear-night.png"
        case .Rain:
            imageName = "rain.png"
        case .Snow:
            imageName = "snow.png"
        case .Sleet:
            imageName = "sleet.png"
        case .Wind:
            imageName = "wind.png"
        case .Fog:
            imageName = "fog.png"
        case .Cloudy:
            imageName = "cloudy.png"
        case .PartlyCloudyDay:
            imageName = "cloudy-day.png"
        case .PartlyCloudyNight:
            imageName = "cloudy-night.png"
        }
        
        return UIImage(named: imageName)
    }
}

struct CurrentWeather {
    let temperature:Int?
    let humidity:Int?
    let precipProbability:Int?
    let summary:String?
    var icon:UIImage? = UIImage(named: "default.png")
    
    
    init(weatherDictionary:[String:AnyObject]){
        
        temperature = weatherDictionary["temperature"] as? Int
        humidity = weatherDictionary["humidity"] as? Int
        precipProbability = weatherDictionary["precipProbability"] as? Int
        summary = weatherDictionary["summary"] as? String
        
        if let iconString = weatherDictionary["icon"] as? String {
            let weatherIcon:Icon = Icon(rawValue: iconString)!
            self.icon = weatherIcon.toImage()
        }
    
    }

}


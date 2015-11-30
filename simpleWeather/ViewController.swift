//
//  ViewController.swift
//  simpleWeather
//
//  Created by 刘卫斌 on 15/11/26.
//  Copyright © 2015年 yufu. All rights reserved.
//

import UIKit

class ViewController: UIViewController,ForecastDelegate {

    @IBOutlet weak var weatherTemperatureLable: UILabel!
    @IBOutlet weak var weatherHumidityLable: UILabel!
    @IBOutlet weak var weatherPrecipitationLable: UILabel!
    @IBOutlet weak var weatherIconImage: UIImageView!
    @IBOutlet weak var weatherSummaryLable: UILabel!
    @IBOutlet weak var refeshActivity: UIActivityIndicatorView!
    @IBOutlet weak var refreshButton: UIButton!
    
    private let APIKey = "bc1336022ffb0f19f9d5b2e8778510e0"
    private let userLocalPosition = (lat:39.8897,lon:115.2750)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        toggleRefreshAnimation(true)
        repostCurrentWeather();
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func GetCurrentWeather(weather: CurrentWeather?) {
        
        if let currently = weather {
            dispatch_async(dispatch_get_main_queue()){
                if let temperature = currently.temperature{
                    self.weatherTemperatureLable.text = "\(temperature)º"
                }
                
                if let humidity = currently.humidity{
                    self.weatherHumidityLable.text = "\(humidity)"
                }
                
                if let precipitation = currently.precipProbability{
                    self.weatherPrecipitationLable.text = "\(precipitation)"
                }
                
                if let currentIcon = currently.icon {
                    self.weatherIconImage.image = currentIcon
                }
                if let summary = currently.summary {
                    self.weatherSummaryLable.text = summary
                }
                self.toggleRefreshAnimation(false)
            }

        }
    }
    
    func repostCurrentWeather(){
        
        var forecastWeather = ForecastService(APIKey: APIKey)
        forecastWeather.delegate = self
        forecastWeather.getForecast(userLocalPosition.lat, lon: userLocalPosition.lon)
        
//        forecastWeather.getForecast(userLocalPosition.lat, lon: userLocalPosition.lon){
//            (let currentWeather) in
//            if let currently = currentWeather {
//                dispatch_async(dispatch_get_main_queue()){
//                    if let temperature = currently.temperature{
//                        self.weatherTemperatureLable.text = "\(temperature)º"
//                    }
//                    
//                    if let humidity = currently.humidity{
//                        self.weatherHumidityLable.text = "\(humidity)"
//                    }
//                    
//                    if let precipitation = currently.precipProbability{
//                        self.weatherPrecipitationLable.text = "\(precipitation)"
//                    }
//                    
//                    if let currentIcon = currently.icon {
//                        self.weatherIconImage.image = currentIcon
//                    }
//                    if let summary = currently.summary {
//                        self.weatherSummaryLable.text = summary
//                    }
//                    self.toggleRefreshAnimation(false)
//                }
//            }
//        }
    
    }

    
    @IBAction func refreshWeather(sender: AnyObject) {
        toggleRefreshAnimation(true)
        repostCurrentWeather();
        
    }
   
    
    func toggleRefreshAnimation(on:Bool){
        refreshButton.hidden = on
        if on {
            refeshActivity.startAnimating()
        } else {
            refeshActivity.stopAnimating()
            
        }
    }
    
    
    
    

    
}


//
//  WeatherForCity.swift
//  WeatherApp
//

import Foundation

class WeatherList: NSObject {
    
    var weatherListArray: NSMutableArray = []
    
    func initWithDictionary(dictionary : NSDictionary) {
        if dictionary.object(forKey: "list") != nil && dictionary.object(forKey: "list") is NSArray {
            let listArray = dictionary.object(forKey: "list") as! NSArray
            if listArray.count > 0 {
                weatherListArray = NSMutableArray()
                for dict in listArray {
                    if dict is NSDictionary {
                        let dictionary = dict as! NSDictionary
                        let weatherForCity = WeatherForCity()
                        let main = dictionary.object(forKey: "main") as! NSDictionary
                        weatherForCity.temperature = String(format: "%@", (main.object(forKey: "temp") as! NSNumber))
                        weatherForCity.feelsLikeTemp = String(format: "%@", (main.object(forKey: "feels_like") as! NSNumber))
                        let weatherList = (dictionary.object(forKey: "weather") as! NSArray).firstObject as! NSDictionary
                        weatherForCity.weather = (weatherList.object(forKey: "main") as! String)
                        weatherForCity.weatherDescription = (weatherList.object(forKey: "description") as! String)
                        weatherListArray.add(weatherForCity)
                    }
                }
            }
        }
    }
}

// MARK: - Weather for city
class WeatherForCity: NSObject {
    var weather: String? = nil
    var weatherDescription: String? = nil
    var temperature: String? = nil
    var feelsLikeTemp: String? = nil
}



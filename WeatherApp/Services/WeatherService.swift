//
//  EmployeesService.swift
//  MVVMExample
//
//  Created by John Codeos on 06/19/20.
//

import Foundation


protocol WeatherServiceProtocol {
    func getWeatherForCity(cityName: String, completion: @escaping (_ success: Bool, _ results: WeatherList?, _ error: String?) -> ())
}

class WeatherService: WeatherServiceProtocol {
    var latitudeOfCity: String = ""
    var longitudeOfCity: String = ""
    
    func getWeatherForCity(cityName: String, completion: @escaping (Bool, WeatherList?, String?) -> ()) {
        // to get latitude and longitude
        getLocationForCity(cityName: cityName) { success, error in
            if success {
                HttpRequestHelper().GET(url: "\(FORECAST_URL)?lat=\(self.latitudeOfCity)&lon=\(self.longitudeOfCity)&appid=\(API_KEY)", complete: { success, data in
                    if success {
                        do {
                            let responseData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                            if responseData is NSDictionary {
                                let weatherList = WeatherList()
                                weatherList.initWithDictionary(dictionary: responseData as! NSDictionary)
                                completion(true, weatherList, nil)
                            } else {
                                completion(false, nil, kParsingError)
                            }
                        } catch {
                            completion(false, nil, kParsingError)
                        }
                    } else {
                        completion(false, nil, kParsingError)
                    }
                })
            } else {
                completion(false, nil, kParsingError)
            }
        }
    }
    
    private func getLocationForCity(cityName: String, completion: @escaping (Bool, String?) -> ()) {
        HttpRequestHelper().GET(url: "\(GEO_COORDINATES_URL)?q=\(cityName)&limit=\(5)&appid=\(API_KEY)", complete: { success, data in
            if success {
                do {
                    let responseData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    if responseData is NSArray {
                        let cityDetails = (responseData as! NSArray).firstObject
                        if cityDetails != nil && cityDetails is NSDictionary {
                            if (cityDetails as! NSDictionary).object(forKey: "lat") != nil {
                                self.latitudeOfCity = String(format: "%@", (cityDetails as! NSDictionary).object(forKey: "lat") as! NSNumber)
                                if (cityDetails as! NSDictionary).object(forKey: "lon") != nil {
                                    self.longitudeOfCity = String(format: "%@", (cityDetails as! NSDictionary).object(forKey: "lon") as! NSNumber)
                                    completion(true, nil)
                                } else {
                                    completion(false, kParsingError)
                                }
                            }
                            else {
                                completion(false, kParsingError)
                            }
                        }
                        else {
                            completion(false, kParsingError)
                        }
                    }
                    else {
                        completion(false, kParsingError)
                    }
                } catch {
                    completion(false, kParsingError)
                }
            } else {
                completion(false, kParsingError)
            }
        })
    }
    
}

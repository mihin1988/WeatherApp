//
//  Constant.swift
//  WeatherApp
//


import Foundation


let FORECAST_URL = "https://api.openweathermap.org/data/2.5/forecast"
let GEO_COORDINATES_URL = "https://api.openweathermap.org/geo/1.0/direct"

let kAlertTitle = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? ""
let kInternetConnectionError = "Please check your Internet Connectivity"
let kParsingError = "Unable to fetch data. Please try again with different city"
let kCityNameValidation = "Please enter valid city"
let kEnterCityName = "Please enter city name"

let kNetworkReachabilityNotification = "NetworkReachabilityNotification"

let API_KEY = "65d00499677e59496ca2f318eb68c049"

var isNetworkReachable: Bool = false


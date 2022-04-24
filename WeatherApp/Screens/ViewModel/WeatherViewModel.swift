//
//  WeatherViewModel.swift
//  WeatherApp
//

import Foundation

class WeatherViewModel: NSObject {
    private var weatherService: WeatherServiceProtocol
    
    var reloadTableView: (() -> Void)?
    var failToFetchResponse: (() -> Void)?
    
    var weathers = WeatherList()
    
    var weatherCellViewModels = [WeatherCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }

    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }
    
    func getWeatherForCity(cityName: String) {
        weatherService.getWeatherForCity(cityName: cityName, completion: { success, model, error in
            if success, let weatherList = model {
                self.fetchWeather(weatherList: weatherList)
            } else {
                print(error!)
                self.failToFetchResponse?()
            }
        })
    }
    
    func fetchWeather(weatherList: WeatherList) {
        self.weathers = weatherList // Cache
        var weatherDetails = [WeatherCellViewModel]()
        for weatherForCity in weathers.weatherListArray {
            weatherDetails.append(createCellModel(weatherForCity: weatherForCity as! WeatherForCity))
        }

        weatherCellViewModels = weatherDetails
    }
        
    func createCellModel(weatherForCity: WeatherForCity) -> WeatherCellViewModel {
        let weather = weatherForCity.weather
        let weatherDescription = weatherForCity.weatherDescription
        let temperature = weatherForCity.temperature
        let feelsLikeTemp = weatherForCity.feelsLikeTemp
        
        return WeatherCellViewModel(weather: weather!, weatherDescription: weatherDescription!, temperature: temperature!, feelsLikeTemperature: feelsLikeTemp!)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> WeatherCellViewModel {
        return weatherCellViewModels[indexPath.row]
    }
}

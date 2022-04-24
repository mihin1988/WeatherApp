//
//  WeatherDisplayViewController.swift
//  WeatherApp
//


import Foundation
import UIKit

class WeatherDisplayViewController: UIViewController {
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelFeelsLikeTemp: UILabel!
    @IBOutlet weak var labelWeatherMain: UILabel!
    @IBOutlet weak var labelWeatherDescription: UILabel!
    
    var cityName: String? = nil
    var weatherModel: WeatherCellViewModel? = nil
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    // MARK: - Set Up View
    
    func setUpView() {
        self.title = "Forecast Details"
        labelWeatherMain.text = weatherModel?.weather
        labelWeatherDescription.text = weatherModel?.weatherDescription
        labelTemperature.text = weatherModel?.temperature
        labelFeelsLikeTemp.text = "Feels Like: " + (weatherModel?.feelsLikeTemperature ?? "")
    }
    
    // MARK: - Button actions
    
    @IBAction func buttonBackTouchUpInside(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
}

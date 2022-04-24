//
//  WeatherListViewController.swift
//  WeatherApp
//

import UIKit

class WeatherListViewController: UIViewController {
    let CELL_IDENTIFIER = "WeatherCellIdentifier"
    
    @IBOutlet var tableViewWeatherList: UITableView!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var labelCityName: UILabel!
    
    var cityName: String? = nil
    
    lazy var viewModel = {
        WeatherViewModel()
    }()

    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpViewModel()
    }

    // MARK: - Set Up View
    
    func setUpView() {
        labelCityName.text = cityName
    }

    // MARK: - Set Up View Model

    func setUpViewModel() {
        // Get weather data
        if isNetworkReachable {
            ActivityIndicator.sharedInstance().startIndicatorOnView(view: self.view, loadingText: "Data is loading..")
            tableViewWeatherList.isHidden = true
            viewModel.getWeatherForCity(cityName: cityName!)
        } else {
            let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: false)
                }
            })
            Utilities.showAlertControllerDialogOnViewController(viewController: self, title: kAlertTitle, message: kInternetConnectionError, actionTitleArray: NSArray(object: alertAction))
        }
        
        viewModel.failToFetchResponse = { [weak self] in
            DispatchQueue.main.async {
                let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                    DispatchQueue.main.async {
                        self?.navigationController?.popViewController(animated: false)
                    }
                })
                Utilities.showAlertControllerDialogOnViewController(viewController: self!, title: kAlertTitle, message: kParsingError, actionTitleArray: NSArray(object: alertAction))
            }
        }
        
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                ActivityIndicator.sharedInstance().stopIndicator()
                self?.tableViewWeatherList.isHidden = false
                self?.tableViewWeatherList.reloadData()
            }
        }
    }
    
    // MARK: - Button actions
    
    @IBAction func buttonBackTouchUpInside(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
}

// MARK: - UITableViewDelegate

extension WeatherListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        //WeatherDisplayViewID
        let weatherDisplayViewController = self.storyboard?.instantiateViewController(withIdentifier: "WeatherDisplayViewID") as! WeatherDisplayViewController
        weatherDisplayViewController.cityName = cityName
        let weatherModel = viewModel.weatherCellViewModels[indexPath.row]
        weatherDisplayViewController.weatherModel = weatherModel
        self.navigationController?.pushViewController(weatherDisplayViewController, animated: false)
    }
}

// MARK: - UITableViewDataSource

extension WeatherListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weatherCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath) as? WeatherListCustomCell else {
            return UITableViewCell()
        }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
}

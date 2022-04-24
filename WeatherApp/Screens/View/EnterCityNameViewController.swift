//
//  EnterCityNameViewController.swift
//  WeatherApp
//

import Foundation
import UIKit

class EnterCityNameViewController: UIViewController {
    
    @IBOutlet weak var textFieldEnterCityName: UITextField!
    @IBOutlet weak var buttonLookUp: UIButton!
        
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search Forecast"
        self.navigationController?.navigationBar.tintColor = .white
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        textFieldEnterCityName.text = ""
    }

    // MARK: - Set Up View
    
    func setUpView() {
        // add bottom border to text field
        let cityNameFrame = CGRect(x: 0, y: textFieldEnterCityName.frame.size.height-2, width: textFieldEnterCityName.frame.size.width, height: 2) as CGRect
        Utilities.addBottomBorderToView(view: textFieldEnterCityName, rect: cityNameFrame, color: UIColor.black)
        
        // add border to button
        buttonLookUp.layer.borderWidth = 1.0
        buttonLookUp.layer.borderColor = UIColor.black.cgColor
        buttonLookUp.layer.cornerRadius = 10.0
        
        // change textfield tint color
        textFieldEnterCityName.tintColor = UIColor.black
    }
    
    // MARK: - Touches begin
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }

    // MARK: - Button actions
    @IBAction func buttonLookUpTouchUpInside(_ sender: UIButton) {
        if textFieldEnterCityName.text != "" {
            if Utilities.isCityNameValid(cityName: textFieldEnterCityName.text!) {
                //WeatherListViewID
                let weatherListViewController = self.storyboard?.instantiateViewController(withIdentifier: "WeatherListViewID") as! WeatherListViewController
                weatherListViewController.cityName = textFieldEnterCityName.text!
                self.navigationController?.pushViewController(weatherListViewController, animated: false)
            } else {
                let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                Utilities.showAlertControllerDialogOnViewController(viewController: self, title: kAlertTitle, message: kCityNameValidation, actionTitleArray: NSArray(object: alertAction))
            }
        }
        else {
            let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            Utilities.showAlertControllerDialogOnViewController(viewController: self, title: kAlertTitle, message: kEnterCityName, actionTitleArray: NSArray(object: alertAction))
        }
    }
    
    
}

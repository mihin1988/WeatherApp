//
//  Utilities.swift
//  WeatherApp
//

import Foundation
import UIKit

class Utilities: NSObject {
    
    static var alertController: UIAlertController? = nil

    // MARK: - View bottom border
    class func addBottomBorderToView(view: UIView, rect: CGRect, color: UIColor) {
        let bottomLayer: CALayer = CALayer()
        bottomLayer.frame = rect
        bottomLayer.backgroundColor = color.cgColor
        view.layer.addSublayer(bottomLayer)
    }
    
    class func isCityNameValid(cityName: String) -> Bool {
        let regex = "^[a-zA-Z\u{0080}-\u{024F}\\s\\/\\-\\)\\(\\`\\.\\\"\\']*$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        if !predicate.evaluate(with: cityName) {
            return false
        }
        else {
            return true
        }
    }
    
    class func showAlertControllerDialogOnViewController(viewController: UIViewController, title: String, message: String, actionTitleArray: NSArray) {
        DispatchQueue.main.async {
            if viewController.navigationController?.visibleViewController is UIAlertController {
                alertController?.dismiss(animated: false, completion: {
                    self.alertController = nil
                })
            }
            alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            for alertActions in actionTitleArray {
                alertController?.addAction(alertActions as! UIAlertAction)
            }
            viewController.present(alertController!, animated: true, completion: nil)
        }
    }
}

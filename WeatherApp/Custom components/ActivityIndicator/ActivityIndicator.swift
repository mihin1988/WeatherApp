//
//  ActivityIndicator.swift
//  TryMyUI
//
//  Created by QuestionPro on 2/14/17.
//  Copyright © 2017 QuestionPro. All rights reserved.
//

import UIKit

class ActivityIndicator: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var activityBgView : UIView?
    var ActivityIndicatorView : UIActivityIndicatorView?
    var labelLoading : UILabel?
    
    class func sharedInstance() -> ActivityIndicator {
        struct Static {
            static let instance = ActivityIndicator()
        }
        return Static.instance
    }
    
    func startIndicatorOnView(view: UIView, loadingText : String) -> Void {
        DispatchQueue.main.async {
            self.removeFromSuperview()
            self.backgroundColor = UIColor.clear
            self.frame = view.frame
            
            if self.activityBgView != nil {
                self.activityBgView?.removeFromSuperview()
                self.activityBgView = nil
            }
            self.activityBgView = UIView(frame: self.frame)
            self.activityBgView?.center = self.center
            self.activityBgView?.backgroundColor = UIColor.black
            self.activityBgView?.alpha = 0.8
            
            if self.ActivityIndicatorView != nil {
                self.ActivityIndicatorView?.removeFromSuperview()
                self.ActivityIndicatorView = nil
            }
            let rect : CGRect
            rect = CGRect(x: 0, y: 0, width: 120, height: 100)
            self.ActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
            self.ActivityIndicatorView?.frame = CGRect(x: (rect.size.width/2) - 20, y: (rect.size.height/2) - 35, width: 40, height: 40)
            self.ActivityIndicatorView?.center = (self.activityBgView?.center)!
            
            if self.labelLoading != nil {
                self.labelLoading?.removeFromSuperview()
                self.labelLoading = nil
            }
            self.labelLoading = UILabel(frame: CGRect(x: 10, y: ((self.ActivityIndicatorView?.frame.origin.y)! + (self.ActivityIndicatorView?.frame.size.height)!+5), width: (self.activityBgView?.frame.size.width)! - 20, height: 60))
            self.labelLoading?.text = loadingText
            self.labelLoading?.font = UIFont(name: "Avenir-Medium", size: 16)
            self.labelLoading?.textAlignment = .center
            self.labelLoading?.textColor = UIColor.white
            self.labelLoading?.numberOfLines = 0
            
            self.activityBgView?.addSubview(self.ActivityIndicatorView!)
            self.activityBgView?.bringSubviewToFront(self.ActivityIndicatorView!)
            self.activityBgView?.addSubview(self.labelLoading!)
            self.addSubview(self.activityBgView!)
            view.addSubview(self)
            
            self.ActivityIndicatorView?.startAnimating()
        }
    }
    
    func stopIndicator() -> Void {
        DispatchQueue.main.async {
            self.ActivityIndicatorView?.stopAnimating()
            self.ActivityIndicatorView?.removeFromSuperview()
            self.ActivityIndicatorView = nil
            self.labelLoading?.removeFromSuperview()
            self.labelLoading = nil
            self.activityBgView?.removeFromSuperview()
            self.activityBgView = nil
            self.removeFromSuperview()
        }
    }

}

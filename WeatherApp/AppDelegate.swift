//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by QuestionPro on 21/04/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var hostReachability: Reachability? = nil
    var internetReachability: Reachability? = nil

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.notifyInternetConnection()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: -  Reachability
    func notifyInternetConnection() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityDidChange), name: ReachabilityChangedNotification, object: nil)
        
        hostReachability = Reachability(hostname: "https://www.apple.com/in")
        do {
            try hostReachability?.startNotifier()
        } catch {
            isNetworkReachable = false
            return
        }
        
        internetReachability = Reachability()
        do {
            try internetReachability?.startNotifier()
        } catch {
            isNetworkReachable = false
            return
        }
    }
    
    // MARK: - Reachability notification observer
    @objc func reachabilityDidChange(notification: NSNotification) {
        if (hostReachability?.currentReachabilityStatus != Reachability.NetworkStatus.notReachable) || (internetReachability?.currentReachabilityStatus != Reachability.NetworkStatus.notReachable) {
            isNetworkReachable = true
            NotificationCenter.default.post(name: NSNotification.Name(kNetworkReachabilityNotification), object: nil)
        }
        else {
            isNetworkReachable = false
        }
    }
    
}


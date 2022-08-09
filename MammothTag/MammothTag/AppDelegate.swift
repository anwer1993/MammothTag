//
//  AppDelegate.swift
//  MammothTag
//
//  Created by Anwar Hajji on 07/08/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch
        
        //        // mainStoryboard
        let mainStoryboard = UIStoryboard(name: "Authentification", bundle: nil)
        
        // rootViewController
        let rootViewController = mainStoryboard.instantiateViewController(withIdentifier: "ViewController")
        
        // navigationController
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        navigationController.isNavigationBarHidden = true // or not, your choice.
        
        // self.window
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.window!.rootViewController = navigationController
        
        self.window!.makeKeyAndVisible()
        return true
    }


}


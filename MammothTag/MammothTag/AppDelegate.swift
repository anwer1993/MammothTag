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
        if let applanguage = AppSettings().appLanguage {
            switch applanguage {
            case .AR :
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
                break
            case .EN:
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
                break
            }
        }
        //        AccountManager.shared.token = nil
        //        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor.redBrown
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        
        //        // mainStoryboard
        let mainStoryboard = UIStoryboard(name: "Authentification", bundle: nil)
        
        // rootViewController
        let rootViewController = mainStoryboard.instantiateViewController(withIdentifier: "SpalchScreen")
        
        // navigationController
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        navigationController.isNavigationBarHidden = true // or not, your choice.
        
        // self.window
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.window!.rootViewController = navigationController
        
        self.window!.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ application: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
        // Process the URL.
        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
              let params = components.queryItems else {
            print("Invalid URL or profilId missing")
            return false
        }
        
        if let applanguage = AppSettings().appLanguage {
            switch applanguage {
            case .AR :
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
                break
            case .EN:
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
                break
            }
        }
        
        if let profilId = params.first(where: { $0.name == "index" })?.value {
            print("photoIndex = \(profilId)")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let rootViewController = storyboard.instantiateViewController(withIdentifier: "ContactDetailsViewController") as? ContactDetailsViewController {
                rootViewController.nfcTag = profilId
                rootViewController.sourceController = 1
                self.window?.rootViewController = rootViewController
                self.window?.makeKeyAndVisible()
            }
            return true
        } else {
            return false
        }
    }
    
}


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
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb else {
            return false
        }

        // Confirm that the NSUserActivity object contains a valid NDEF message.
        let ndefMessage = userActivity.ndefMessagePayload
        guard !ndefMessage.records.isEmpty,
            ndefMessage.records[0].typeNameFormat != .empty else {
                return false
        }

        // Send the message to `MessagesTableViewController` for processing.
        guard let navigationController = window?.rootViewController as? UINavigationController else {
            return false
        }

        navigationController.popToRootViewController(animated: true)
//        let messageTableViewController = navigationController.topViewController as? MessagesTableViewController
//        messageTableViewController?.addMessage(fromUserActivity: ndefMessage)

        return true
    }


}


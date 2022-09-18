//
//  AppDelegate.swift
//  MammothTag
//
//  Created by Anwar Hajji on 07/08/2022.
//

import UIKit
import Branch
import CoreNFC

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb else {
            return false
        }

        // Confirm that the NSUserActivity object contains a valid NDEF message.
        let ndefMessage = userActivity.ndefMessagePayload
        guard !ndefMessage.records.isEmpty,
            ndefMessage.records[0].typeNameFormat != .empty else {
                return false
        }
        guard let payload = ndefMessage.records.first else {return false}
        switch payload.typeNameFormat {
        case .nfcWellKnown:
            if let type = String(data: payload.type, encoding: .utf8) {
                if let url = payload.wellKnownTypeURIPayload() {
                    print("\(payload.typeNameFormat.description): \(type), \(url.absoluteString)")
                    let lastPath = url.lastPathComponent
                    if let startIndex = lastPath.firstIndex(of: "=") {
                        let indeex = lastPath.index(startIndex, offsetBy: 1)
                        let UUID = String(lastPath[indeex...])
                        print(UUID)
                        if let token = AccountManager.shared.token {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            if let rootViewController = storyboard.instantiateViewController(withIdentifier: "ContactDetailsViewController") as? ContactDetailsViewController {
                                rootViewController.nfcTag = UUID
                                rootViewController.sourceController = 1
                                self.window?.rootViewController = rootViewController
                                self.window?.makeKeyAndVisible()
                                return true
                            } else {
                                return false
                            }
                        } else {
                            let storyboard = UIStoryboard(name: "Authentification", bundle: nil)
                            if let rootViewController = storyboard.instantiateViewController(withIdentifier: "SignInController") as? SignInController {
                                rootViewController.sourceController = 1
                                rootViewController.nfcTagId = UUID
                                self.window?.rootViewController = rootViewController
                                self.window?.makeKeyAndVisible()
                                return true
                            } else {
                                return false
                            }
                        }
                        
                    } else {
                        return false
                    }
                }
            }
        case .absoluteURI:
            break
        case .media:
            break
        case .nfcExternal, .empty, .unknown, .unchanged:
            fallthrough
        @unknown default:
            break
        }
      return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // if you are using the TEST key
          Branch.setUseTestBranchKey(true)
          // listener for Branch Deep Link data
          Branch.getInstance().initSession(launchOptions: launchOptions) { (params, error) in
          }

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
        Branch.getInstance().application(application, open: url, options: options)
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


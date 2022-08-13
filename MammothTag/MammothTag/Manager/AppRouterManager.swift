//
//  AppRouterManager.swift
//  MammothTag
//
//  Created by Anwar Hajji on 09/08/2022.
//

import Foundation
import UIKit

/// Protocol handle the router functionality
protocol IRouter {
    func present(screen: AppScreen, modalePresentatioinStyle: UIModalPresentationStyle, completion: (() -> Void)?)
    func push(with navigationController: UINavigationController?, screen: AppScreen, animated: Bool)
    var topVC: UIViewController? {get}
}

/// Protocol to handle the app's screens
protocol INaviagtion{}

/// the enumaration that define the different view controller in the app
enum AppScreen: INaviagtion{
    case Login
    case ForgotPassword
    case Register
    case Terms
    case ContactList
    case Settings
    case Tabbar
}

/// Class responsible for the routing functionality
struct Router: IRouter {
    
    struct Static {
        static let sharedInstance = Router()
    }
    
    static var shared = Static.sharedInstance
    
    /// Get the top view controller in the app
    var topVC: UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController  {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
    
    /// Instantiate the view controller and prepare it for the navigation
    /// - Parameters:
    ///   - screen: the app screen that we will navigate to it
    ///   - modalePresentatioinStyle: the prsentation style
    /// - Returns: return the corresponding view controller for the current screen
    private func viewControllerForNavigation(screen: INaviagtion, modalePresentatioinStyle: UIModalPresentationStyle?) -> UIViewController {
        var viewController = UIViewController()
        if let screen = screen as? AppScreen {
            switch screen {
            case .Login:
                guard let vc = SignInController.instantiate(storyboardName: "Authentification") else {return UIViewController()}
                viewController = vc
                break
            case .ForgotPassword:
                guard let vc = ForgotPasswordController.instantiate(storyboardName: "Authentification") else {return UIViewController()}
                viewController = vc
                break
            case .Register:
                guard let vc = RegisterViewController.instantiate(storyboardName: "Authentification") else {return UIViewController()}
                viewController = vc
                break
            case .Terms:
                guard let vc = TermsAndConditionViewController.instantiate(storyboardName: "Authentification") else {return UIViewController()}
                viewController = vc
                break
            case .ContactList:
                guard let vc = ContactListViewController.instantiate(storyboardName: "Main") else {return UIViewController()}
                viewController = vc
                break
            case .Settings:
                guard let vc = SettingsViewController.instantiate(storyboardName: "Main") else {return UIViewController()}
                viewController = vc
                break
            case .Tabbar:
                guard let vc = MainTabbarViewController.instantiate(storyboardName: "Main") else {return UIViewController()}
                let navController = UINavigationController(rootViewController: vc)
                viewController = navController
                break
            }
        }
        if modalePresentatioinStyle != nil {
            viewController.modalPresentationStyle = modalePresentatioinStyle!
        }
        return viewController
    }
    
    /// present View controller
    /// - Parameters:
    ///   - screen: the corresponding screen
    ///   - modalePresentatioinStyle: the presentation style
    ///   - completion: completion handled when present the view controller
    func present(screen: AppScreen, modalePresentatioinStyle: UIModalPresentationStyle, completion: (() -> Void)?) {
        DispatchQueue.main.async {
            if let topVC = self.topVC {
                topVC.present(self.viewControllerForNavigation(screen: screen, modalePresentatioinStyle: modalePresentatioinStyle), animated: false, completion:{
                    if completion != nil {
                        completion!()
                    }
                })
            }
        }
    }
    
    /// push view controller
    /// - Parameters:
    ///   - navigationController: the navigation controller that will push the view controller
    ///   - screen: the screen we will push it
    ///   - animated: the animation value
    func push(with navigationController: UINavigationController?, screen: AppScreen, animated: Bool) {
        DispatchQueue.main.async {
            navigationController?.pushViewController(self.viewControllerForNavigation(screen: screen, modalePresentatioinStyle: nil), animated: animated)
        }
    }
    
    /// Dismiss to root view Controller
    /// - Parameter completion: Completion handled when dismiss to the root view controller
    func dismissToRootViewController(completion: @escaping () -> Void) {
        topVC?.view.window?.rootViewController?.dismiss(animated: false, completion: {
            completion()
        })
    }
}





/// Protocol use to instantiate view controller from storyboard
protocol Storyboarded {
    static func instantiate(storyboardName: String) -> Self?
}

extension Storyboarded where Self: UIViewController {
    
    /// instantiate view controller from storyboard
    /// - Parameter storyboardName: storyboard name
    /// - Returns: return the view controller instantiated
    static func instantiate(storyboardName: String) -> Self? {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)
        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]
        // load our storyboard
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: className) as? Self
    }
}


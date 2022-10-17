//
//  UIViewControllerExtension.swift
//  MammothTag
//
//  Created by Anwar Hajji on 12/08/2022.
//

import Foundation
import UIKit
import FirebaseAuth

extension UIViewController {
    
    func addChildVc(_ childVc: SubViewConroller, actionWhenDismiss: @escaping () -> Void) {
        childVc.handleTapWhenDismiss = {
            actionWhenDismiss()
        }
        self.addChild(childVc)
        self.view.addSubview(childVc.view)
        childVc.didMove(toParent: self)
        let leading = childVc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailing = childVc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let top = childVc.view.topAnchor.constraint(equalTo: view.topAnchor)
        let bottom = childVc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
        childVc.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func showAlert(withTitle title: String, withMessage message: String, confirmAction: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "CANCEL".localized, style: .cancel)
        let OkAction = UIAlertAction(title: "OK".localized, style: .default) { _ in
            if let handler = confirmAction {
                handler()
            }
        }
        if confirmAction != nil {
            alert.addAction(cancelAction)
        }
        alert.addAction(OkAction)
        self.present(alert, animated: true)
    }
    
    func showAlertWithOk(withTitle title: String, withMessage message: String, confirmAction: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OkAction = UIAlertAction(title: "OK".localized, style: .default) { _ in
            if let handler = confirmAction {
                handler()
            }
        }
        alert.addAction(OkAction)
        self.present(alert, animated: true)
    }
    
    func showOrHideLoader(done: Bool) {
        if done {
            dismiss(animated: false, completion: nil)
        } else {
            let alert = UIAlertController(title: nil, message: "PLEASE_WAIT".localized, preferredStyle: .alert)

            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.medium
            loadingIndicator.startAnimating()
            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func expireSession(isExppired: Bool = false) {
        showOrHideLoader(done: false)
        if !isExppired {
            if let token = AccountManager.shared.token {
                AuthenticationService.sharedInstance.logout(token: token) { data in
                    self.showOrHideLoader(done: true)
                    let firebaseAuth = Auth.auth()
                    do {
                      try firebaseAuth.signOut()
                    } catch let signOutError as NSError {
                      print("Error signing out: %@", signOutError)
                    }
                    if let done = data.success, done == true {
                        AccountManager.shared.token = nil
                        AccountManager.shared.isApproved = false
                        Contstant.updateRootVC()
                    } else {
                        AccountManager.shared.token = nil
                        AccountManager.shared.isApproved = false
                        Contstant.updateRootVC()
                    }
                }
            } else {
                self.showOrHideLoader(done: true)
                AccountManager.shared.token = nil
                AccountManager.shared.isApproved = false
                Contstant.updateRootVC()
            }
        } else {
            self.showOrHideLoader(done: true)
            AccountManager.shared.token = nil
            AccountManager.shared.isApproved = false
            Contstant.updateRootVC()
        }
        
    }
    
    func logout() {
        self.showAlert(withTitle: "LOGOUT".localized, withMessage: "LOGOUT_ALERT_MESSAGE".localized, confirmAction: {[weak self]  in
            guard let this = self else {
                return
            }
            this.expireSession()
        })
    }
    
    func deleteAccount() {
        if let token = AccountManager.shared.token {
            self.showOrHideLoader(done: false)
            AuthenticationService.sharedInstance.deleteAccount(token: token) { [weak self] resp in
                guard let this = self else {return}
                this.showOrHideLoader(done: true)
                if let resp = resp {
                    if let done = resp.result, done == true {
                        let domain = Bundle.main.bundleIdentifier!
                        UserDefaults.standard.removePersistentDomain(forName: domain)
                        UserDefaults.standard.synchronize()
                        Contstant.updateRootVC()
                    }
                } else {
                    this.showOrHideLoader(done: true)
                    AccountManager.shared.token = nil
                    AccountManager.shared.isApproved = false
                    Contstant.updateRootVC()
                }
            }
        }
    }
    
    
    
}

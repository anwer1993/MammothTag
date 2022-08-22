//
//  UIViewControllerExtension.swift
//  MammothTag
//
//  Created by Anwar Hajji on 12/08/2022.
//

import Foundation
import UIKit

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
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let OkAction = UIAlertAction(title: "Ok", style: .default) { _ in
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
        let OkAction = UIAlertAction(title: "Ok", style: .default) { _ in
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
            let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.medium
            loadingIndicator.startAnimating();

            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
}

//
//  UIViewControllerExtension.swift
//  MammothTag
//
//  Created by Anwar Hajji on 12/08/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
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
    
    
}

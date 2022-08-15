//
//  UIDeviceExtension.swift
//  MammothTag
//
//  Created by Anwar Hajji on 11/08/2022.
//

import Foundation
import UIKit

extension UIDevice {
    /// Returns `true` if the device has a notch
    var hasNotch: Bool {
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return false }
        if UIDevice.current.orientation.isPortrait {
            return window.safeAreaInsets.top >= 44
        } else {
            return window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0
        }
    }
}

extension UIApplication {
    var statusBarUIView: UIView? {
            if #available(iOS 13.0, *) {
                let tag = 38482458385
                if let statusBar = self.keyWindow?.viewWithTag(tag) {
                    return statusBar
                } else {
                    let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
                    statusBarView.tag = tag

                    self.keyWindow?.addSubview(statusBarView)
                    return statusBarView
                }
            } else {
                if responds(to: Selector(("statusBar"))) {
                    return value(forKey: "statusBar") as? UIView
                }
            }
            return nil
        }
}



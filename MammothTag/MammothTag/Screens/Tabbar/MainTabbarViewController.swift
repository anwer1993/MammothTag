//
//  MainTabbarViewController.swift
//  MammothTag
//
//  Created by Anwar Hajji on 11/08/2022.
//

import UIKit

class MainTabbarViewController: UITabBarController  {
    
    var customTabbarView: CustomTabbarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let y: CGFloat  = UIDevice().hasNotch ? 0 : -20
        let frame = CGRect(x: 0, y: y, width: tabBar.bounds.width, height: tabBar.bounds.height + 50)
        customTabbarView = CustomTabbarView(frame: frame)
        self.tabBar.addSubview(customTabbarView)
        customTabbarView.backgroundColor = .redBrown
        customTabbarView.layer.cornerRadius = 25.0
        customTabbarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        customTabbarView.applySketchShadow(color: UIColor.redBrown48, alpha: 1, x: 0, y: 5, blur: 20, spread: 0)
        tabBar.backgroundColor = .clear
        customTabbarView.didSelectItem = { selectedIndex in
            self.selectedIndex = selectedIndex
        }
    }
    
}

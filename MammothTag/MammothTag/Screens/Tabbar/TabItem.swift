//
//  TabItem.swift
//  CustomTabNavigation
//
//  Created by Sprinthub on 09/10/2019.
//  Copyright © 2019 Sprinthub Mobile. All rights reserved.
//

// Changed by Agha Saad Rehman

import UIKit

enum TabItem: String, CaseIterable {
    case home = "home"
    case calender = "calender"
    case friends = "friends"
    case profile = "profile"
    
    
    var viewController: UIViewController {
        switch self {
        case .home:
            return SettingsViewController()
        case .calender:
            return ContactListViewController()
        case .friends:
            return ContactListViewController()
        case .profile:
            return ContactListViewController()
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .home:
            return UIImage(named: "home")!
        case .calender:
            return UIImage(named: "home")!
        case .friends:
            return UIImage(named: "home")!
        case .profile:
            return UIImage(named: "home")!
        }
    }
    
    var displayTitle: String {
        return self.rawValue.capitalized(with: nil)
    }
}

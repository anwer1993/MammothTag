//
//  ViewController.swift
//  MammothTag
//
//  Created by Anwar Hajji on 07/08/2022.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let token = AccountManager.shared.token , !token.isEmptyString {
            Router.shared.push(with: self.navigationController, screen: .Tabbar, animated: true)
        } else {
            Router.shared.push(with: self.navigationController, screen: .Login, animated: true)
        }
    }
    
    
}



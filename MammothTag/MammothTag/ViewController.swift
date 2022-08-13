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
        if AccountManager.shared.isLoggedIn {
            Router.shared.present(screen: .Tabbar, modalePresentatioinStyle: .fullScreen, completion: nil)
        } else {
            Router.shared.push(with: self.navigationController, screen: .Login, animated: true)
        }
        
        // Do any additional setup after loading the view.
    }
    
    
}



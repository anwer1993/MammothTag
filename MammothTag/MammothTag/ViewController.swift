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
        Router.shared.push(with: self.navigationController, screen: .Login, animated: true)
        // Do any additional setup after loading the view.
    }
    
    
}



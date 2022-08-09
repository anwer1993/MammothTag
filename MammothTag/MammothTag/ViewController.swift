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
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let s = UIStoryboard(name: "Authentification", bundle: nil)
            let vc = s.instantiateViewController(withIdentifier: "SignInController")
            self.navigationController?.pushViewController(vc, animated: true)
        }
        // Do any additional setup after loading the view.
    }
    
    
}



//
//  ScanNFCVC.swift
//  MammothTag
//
//  Created by Anwar Hajji on 12/08/2022.
//

import Foundation
import UIKit

class ScanNFCVC: UIViewController {
    

    @IBOutlet weak var viewControl: UIControl!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var scanNFCDescriptionLbl: UILabel!
    @IBOutlet weak var scanNFCLbl: UILabel!
    @IBOutlet weak var scanNFCIcon: UIImageView!
    @IBOutlet weak var scanNFCView: UIView!
    
    var handleTapWhenDismiss: () -> Void = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func initView() {
        viewControl.addTarget(self, action: #selector(removeView(_:)), for: .touchUpInside)
        viewControl.alpha = 0.5
        closeButton.layer.cornerRadius = closeButton.frame.width * 0.5
        scanNFCView.layer.cornerRadius = 30.0
        scanNFCView.layer.maskedCorners = [.layerMaxXMinYCorner]
    }
    
    @objc func removeView(_ gesture: UIGestureRecognizer) {
        removeView()
    }
    
    func removeView() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
        handleTapWhenDismiss()
    }
    
    @IBAction func closeButtonDidTapped(_ sender: Any) {
        removeView()
    }
    
    
    
    
    
    
}

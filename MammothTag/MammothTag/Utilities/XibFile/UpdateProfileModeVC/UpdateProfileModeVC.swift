//
//  UpdateProfileModeVC.swift
//  MammothTag
//
//  Created by Anwar Hajji on 12/08/2022.
//

import Foundation
import UIKit

class UpdateProfileModeVC : UIViewController {
    
    @IBOutlet weak var viewControl: UIControl!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var selectProfileLbl: UILabel!
    @IBOutlet weak var menuStackView: UIStackView!
    @IBOutlet weak var publicLbl: UILabel!
    @IBOutlet weak var profileInsideView: UIView!
    @IBOutlet weak var publicViewContainer: UIView!
    @IBOutlet weak var publicStackView: UIStackView!
    @IBOutlet weak var privateStackView: UIStackView!
    @IBOutlet weak var privateViewContainer: UIView!
    @IBOutlet weak var privateInsideView: UIView!
    @IBOutlet weak var privateLbl: UILabel!
    
    @IBOutlet weak var saveBtn: GradientButton!
    
    var handleTapWhenDismiss: () -> Void = {}
    var updateProfileeMode: () -> Void = {}
    
    var selectedMode: Int = 0 {
        didSet {
            updateUIWhenSelectMode()
            
        }
    }
    
    var tapGesture: UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func customizeView(_ view: UIView, insideView: UIView) {
        view.layer.cornerRadius = view.frame.width * 0.5
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.redBrown.cgColor
        insideView.layer.cornerRadius = insideView.frame.width * 0.5
        insideView.layer.backgroundColor = UIColor.redBrown.cgColor
    }
    
    func deselectView(_ view: UIView, insideView: UIView) {
        view.layer.borderColor = UIColor.warmGreyTwo.cgColor
        insideView.isHidden = true
    }
    
    func selectView(_ view: UIView, insideView: UIView) {
        view.layer.borderColor = UIColor.redBrown.cgColor
        insideView.isHidden = false
    }
    
    func initView() {
        selectedMode = AccountManager.shared.profileMode?.rawValue ?? 0
        viewControl.addTarget(self, action: #selector(removeView(_:)), for: .touchUpInside)
        viewControl.alpha = 0.5
        publicStackView.tag = 0
        privateStackView.tag = 1
        downButton.layer.cornerRadius = downButton.frame.width * 0.5
        menuView.layer.cornerRadius = 30.0
        menuView.layer.maskedCorners = [.layerMaxXMinYCorner]
        customizeView(publicViewContainer, insideView: profileInsideView)
        customizeView(privateViewContainer, insideView: privateInsideView)
        updateUIWhenSelectMode()
        publicStackView.addTagGesture(tapGesture)
        privateStackView.addTagGesture(tapGesture)
        saveBtn.gradientbutton()
    }
    
    func updateUIWhenSelectMode() {
        switch selectedMode {
        case 0:
            selectView(publicViewContainer, insideView: profileInsideView)
            deselectView(privateViewContainer, insideView: privateInsideView)
            break
        case 1:
            selectView(privateViewContainer, insideView: privateInsideView)
            deselectView(publicViewContainer, insideView: profileInsideView)
            break
        default:
            break
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if let tag = sender?.view?.tag {
            selectedMode = tag
        }
    }
    
    @IBAction func saveBtnDidTapped(_ sender: Any) {
        AccountManager.shared.profileMode = ProfileMode(rawValue: selectedMode)
        removeView()
    }
    
    /// remove view from this view controller
    @objc func removeView(_ gesture: UIGestureRecognizer) {
        removeView()
    }
    
    /// Hide participant list action
    @IBAction func hideMenuView(_ sender: Any) {
        removeView()
    }
    
    /// remove view
    func removeView() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
        selectedMode = AccountManager.shared.profileMode?.rawValue ?? 0
        handleTapWhenDismiss()
    }
    
}

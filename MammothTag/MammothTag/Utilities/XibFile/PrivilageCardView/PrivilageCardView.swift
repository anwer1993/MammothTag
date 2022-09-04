//
//  PrivilageCardView.swift
//  MammothTag
//
//  Created by Anwar Hajji on 03/09/2022.
//

import Foundation
import UIKit

class PrivilageCardView: UIViewController, SubViewConroller {
    
    
    
    
    @IBOutlet weak var privateStack: UIStackView!
    @IBOutlet weak var privateLbl: UILabel!
    @IBOutlet weak var privateSubView: UIView!
    @IBOutlet weak var privatePArentView: UIView!
    @IBOutlet weak var profileLbl: UILabel!
    @IBOutlet weak var profileSsubView: UIView!
    @IBOutlet weak var profileParentView: UIView!
    @IBOutlet weak var profileStack: UIStackView!
    @IBOutlet weak var saveBtn: GradientButton!
    @IBOutlet weak var menuStack: UIStackView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var viewControl: UIControl!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    
    var handleTapWhenDismiss: () -> Void = {}
    
    var handleTapWhenSave: (String) -> Void = {_ in}
    
    var tapGesture: UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    }
    
    var selectedMode: Int = 0 {
        didSet {
//            updateUIWhenSelectMode()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView() {
        viewControl.addTarget(self, action: #selector(removeView(_:)), for: .touchUpInside)
        viewControl.alpha = 0.5
        closeBtn.layer.cornerRadius = closeBtn.frame.width * 0.5
        menuView.layer.cornerRadius = 30.0
        menuView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        customizeView(profileParentView, insideView: profileSsubView)
        customizeView(privatePArentView, insideView: privateSubView)
        profileStack.tag = 0
        profileStack.addTagGesture(tapGesture)
        privateStack.tag = 1
        privateStack.addTagGesture(tapGesture)
        saveBtn.gradientbutton()
        saveBtn.applySketchShadow(color: .tangerine30, alpha: 1, x: 0, y: 10, blur: 30, spread: 0)
        updateUIWhenSelectMode()
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
    
    func updateUIWhenSelectMode() {
        switch selectedMode {
        case 1:
            selectView(privatePArentView, insideView: privateSubView)
            deselectView(profileParentView, insideView: profileSsubView)
            break
        case 0:
            deselectView(privatePArentView, insideView: privateSubView)
            selectView(profileParentView, insideView: profileSsubView)
            break
        default:
            break
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if let tag = sender?.view?.tag {
            selectedMode = tag
            updateUIWhenSelectMode()
        }
    }
    
    @objc func removeView(_ gesture: UIGestureRecognizer) {
        removeView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.menuView.endEditing(true)
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
    
    @IBAction func saveBtnDidTapped(_ sender: Any) {
        handleTapWhenSave("\(selectedMode)")
    }
    
}

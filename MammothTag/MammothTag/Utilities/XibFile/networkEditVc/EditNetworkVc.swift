//
//  EditNetworkVc.swift
//  MammothTag
//
//  Created by Anwar Hajji on 03/09/2022.
//

import Foundation
import UIKit

class EditNetworkVc: UIViewController, SubViewConroller {
    
    
    @IBOutlet weak var menuViewBottomConstrainte: NSLayoutConstraint!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var viewControl: UIControl!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var saveBtnn: UIButton!
    @IBOutlet weak var openTn: GradientButton!
    
    @IBOutlet weak var deleteIcon: UIImageView!
    
    var handleTapWhenDismiss: () -> Void = {}
    var handleTapWhenSave: (CardNetworkProfile) -> () = {_ in}
    var handleTapWhenOpen: (CardNetworkProfile) -> () = {_ in}
    var handleTapWhenDelete: (CardNetworkProfile) -> () = {_ in}
    var link: String = ""
    var network: CardNetworkProfile?
    
    var menuViewBottomConstrainnteOriginal: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initView()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        menuViewBottomConstrainnteOriginal = menuViewBottomConstrainte.constant
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            print(keyboardSize.origin.y)
            if self.menuView.frame.origin.y + self.menuView.frame.height > keyboardSize.origin.y {
                print("passwordTextField hidden")
                menuViewBottomConstrainte.constant = keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        menuViewBottomConstrainte.constant = menuViewBottomConstrainnteOriginal
    }
    
    func initView() {
        viewControl.addTarget(self, action: #selector(removeView(_:)), for: .touchUpInside)
        viewControl.alpha = 0.5
        closeBtn.layer.cornerRadius = closeBtn.frame.width * 0.5
        menuView.layer.cornerRadius = 30.0
        menuView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        openTn.gradientbutton()
        openTn.applySketchShadow(color: .tangerine30, alpha: 1, x: 0, y: 10, blur: 30, spread: 0)
        saveBtnn.applySketchShadow(color: .black9, alpha: 1, x: 0, y: 10, blur: 30, spread: 0)
        saveBtnn.layer.borderColor = UIColor.black.cgColor
        saveBtnn.layer.borderWidth = 1
        saveBtnn.layer.cornerRadius  = 20.0
        deleteView.layer.cornerRadius = deleteView.frame.width * 0.5
        deleteIcon.layer.cornerRadius = deleteIcon.frame.width * 0.5
        deleteIcon.image = deleteIcon.image?.withRenderingMode(.alwaysTemplate)
        deleteIcon.tintColor = .red
        deleteView.applySketchShadow(color: .black9, alpha: 1, x: 0, y: 10, blur: 30, spread: 0)
        let bottomLine = CALayer()
        let width = UIScreen.main.bounds.width - 48
        bottomLine.frame = CGRect(x: 0.0, y: 38, width: width, height: 1.0)
        bottomLine.backgroundColor = UIColor.pinkishGrey.cgColor
        linkTextField.borderStyle = UITextField.BorderStyle.none
        linkTextField.layer.addSublayer(bottomLine)
        linkTextField.delegate = self
        if let network = network {
            linkTextField.text = network.link
        }
        let tapGestsure = UITapGestureRecognizer(target: self, action: #selector(deleteNetwork(_:)))
        deleteView.addTagGesture(tapGestsure)
        titleLbl.font = UIFont(name: "Lato-Bold", size: 18)
        titleLbl.textColor = .redBrown
        linkTextField.font = UIFont(name: "Lato-Regular", size: 16)
        saveBtnn.titleLabel?.font = UIFont(name: "Lato-SemiBold", size: 16)
        openTn.titleLabel?.font = UIFont(name: "Lato-SemiBold", size: 16)
        openTn.setTitle("OPEN".localized, for: .normal)
        saveBtnn.setTitle("SAVE".localized, for: .normal)
        titleLbl.text = "SOCIAL_EDIT_LINK".localized
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
    
    @objc func deleteNetwork(_ gesture: UITapGestureRecognizer? = nil) {
        guard let network = network else {
            return
        }
        handleTapWhenDelete(network)
    }
    
    @IBAction func closeButtonDidTapped(_ sender: Any) {
        removeView()
    }
    
    @IBAction func saveBtnDidTapped(_ sender: Any) {
        guard let network = network else {
            return
        }
        var editedLink = ""
        if link.isEmptyString {
            editedLink = network.link ?? ""
        } else {
            editedLink = link
        }
        let editedNetwork = CardNetworkProfile(id: network.id, cardID: network.cardID, socialNetworkID: network.socialNetworkID, link: editedLink, status: network.status, isOpenFirst: network.isOpenFirst, createdAt: network.createdAt, updatedAt: network.updatedAt)
        handleTapWhenSave(editedNetwork)
    }
    
    
    @IBAction func openBtnDidTapped(_ sender: Any) {
        guard let network = network else {
            return
        }
        handleTapWhenOpen(network)
    }
}


extension EditNetworkVc: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        link = textField.text ?? ""
        return true;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        link = textField.text ?? ""
        print("TextField did begin editing method called")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        link = textField.text ?? ""
        print("TextField did end editing method called")
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        link = textField.text ?? ""
        print("TextField did change", link)
    }
    
}

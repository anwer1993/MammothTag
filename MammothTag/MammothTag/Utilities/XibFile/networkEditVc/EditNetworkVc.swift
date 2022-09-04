//
//  EditNetworkVc.swift
//  MammothTag
//
//  Created by Anwar Hajji on 03/09/2022.
//

import Foundation
import UIKit

class EditNetworkVc: UIViewController, SubViewConroller {
    
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
    var handleTapWhenSave: (DatumListCardNetwork) -> () = {_ in}
    var handleTapWhenOpen: (DatumListCardNetwork) -> () = {_ in}
    var handleTapWhenDelete: (DatumListCardNetwork) -> () = {_ in}
    var link: String = ""
    var network: DatumListCardNetwork?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initView()
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
        let editedNetwork = DatumListCardNetwork(id: network.id, cardID: network.cardID, socialNetworkID: network.socialNetworkID, link: editedLink, status: network.status, createdAt: network.createdAt, updatedAt: network.updatedAt, isOpenFirst: network.isOpenFirst)
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

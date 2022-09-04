//
//  AddSocialMediaVc.swift
//  MammothTag
//
//  Created by Anwar Hajji on 31/08/2022.
//

import Foundation
import UIKit

class AddSocialMediaVc: UIViewController, SubViewConroller {
    
    
    @IBOutlet weak var menuViewBottomConstrainte: NSLayoutConstraint!
    @IBOutlet var viewContainer: UIView!
    @IBOutlet weak var viewControl: UIControl!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var socialMediaIcon: UIImageView!
    @IBOutlet weak var socialMediaName: UILabel!
    
    @IBOutlet weak var switcherIcon: UIImageView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var saveButtonn: GradientButton!
    
    
    var handleTapWhenDismiss: () -> Void = {}
    var handleAddSocialMediaAction: (AddCardNetworkServerResponseModel?) -> () = {_ in}
    
    var selectedCard : DatumCard?
    var socialMediaID: Int?
    var link: String = ""
    var status: Int = 1
    var statusOff: Bool = true
    
    var menuViewBottomConstrainnteOriginal: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(updateStatus(_:)))
        switcherIcon.addTagGesture(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        closeButton.layer.cornerRadius = closeButton.frame.width * 0.5
        socialMediaIcon.layer.cornerRadius = socialMediaIcon.frame.width * 0.5
        menuView.layer.cornerRadius = 30.0
        menuView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let bottomLine = CALayer()
        let width = UIScreen.main.bounds.width - 48
        bottomLine.frame = CGRect(x: 0.0, y: 54, width: width, height: 1.0)
        bottomLine.backgroundColor = UIColor.pinkishGrey.cgColor
        textField.borderStyle = UITextField.BorderStyle.none
        textField.layer.addSublayer(bottomLine)
        textField.delegate = self
        if let socialMedia = Contstant.data.first(where: {$0.socialMediaId == socialMediaID}) {
            socialMediaIcon.image = UIImage(named: socialMedia.imageName ?? "")
            socialMediaName.text = socialMedia.socialMediaName
        }
        
        socialMediaName.font = UIFont(name: "Lato-Bold", size: 18)
        socialMediaName.textColor = .redBrown
        textField.font = UIFont(name: "Lato-Regular", size: 16)
        saveButtonn.titleLabel?.font = UIFont(name: "Lato-SemiBold", size: 16)
        saveButtonn.setTitle("SAVE".localized, for: .normal)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.menuView.endEditing(true)
    }
    
    @objc func removeView(_ gesture: UIGestureRecognizer) {
        removeView()
    }
    
    func removeView() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
        textField.text = ""
        status = 1
        handleTapWhenDismiss()
    }
    
    @objc func updateStatus(_ gesture: UIGestureRecognizer) {
        statusOff.toggle()
        if statusOff {
            status = 1
            switcherIcon.image = UIImage(named: "switch_on")
        } else {
            status = 0
            switcherIcon.image = UIImage(named: "switch_off")
        }
    }
    
    @IBAction func saveButtonDidTapped(_ sender: Any) {
        guard link.isEmptyString == false else {
            showAlertWithOk(withTitle: "Error", withMessage: "Social media link is required")
            return
        }
        if let token = AccountManager.shared.token {
            showOrHideLoader(done: false)
            CardService.shared.addCardNetwork(card_id: "\(selectedCard?.id ?? 0)", social_network_id: "\(socialMediaID ?? 0)", link: link, status: "\(status)", token: token) { [weak self] resp in
                guard let this = self else {return}
                this.showOrHideLoader(done: true)
                this.removeView()
                this.handleAddSocialMediaAction(resp)
            }
        }
    }
    
}


extension AddSocialMediaVc: UITextFieldDelegate {
    
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

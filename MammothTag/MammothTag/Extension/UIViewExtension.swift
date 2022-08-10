//
//  UIViewExtension.swift
//  MammothTag
//
//  Created by Anwar Hajji on 08/08/2022.
//

import Foundation
import UIKit

extension UIView {
    
    func applySketchShadow(color: UIColor , alpha: Float, x: CGFloat, y: CGFloat, blur: CGFloat, spread: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = alpha
        self.layer.shadowOffset = CGSize(width: x, height: y)
        self.layer.shadowRadius = blur / 2.0
        if spread == 0 {
            self.layer.shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            self.layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
    func customizeViewForContainTextField() {
        self.layer.cornerRadius = 15
        self.applySketchShadow(color: UIColor.tangerine30, alpha: 1, x: 0, y: 5, blur: 20, spread: 0)
    }
    
    func customizeViewContainTextFieldWhenError() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.pinkishRed.cgColor
        layer.backgroundColor = UIColor.white.cgColor
    }
    
    func customizeViewContainTextFieldWhenValid() {
        layer.borderWidth = 0
        layer.backgroundColor = UIColor(displayP3Red: 241/255, green: 232/255, blue: 227/255, alpha: 1).cgColor
    }
    
}


extension UILabel {
    
    func applyLineView(lineColor: UIColor) {
        let frame = CGRect(x: 0, y: self.bounds.size.height, width: self.bounds.size.width, height: 1)
        let lineView = UIView(frame: frame)
        lineView.backgroundColor = lineColor
        self.addSubview(lineView)
    }
    
    
    func customizeTextLabel(stringToColor: String, color: UIColor, isUnderline: Bool = false) -> NSAttributedString {
        guard let text = self.text else {return NSAttributedString()}
        let range = (text as NSString).range(of: stringToColor)
        let mutableAttributedString = NSMutableAttributedString.init(string: text)
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: font.pointSize)]
        mutableAttributedString.addAttributes(boldFontAttribute, range: range)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        if isUnderline {
            mutableAttributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: range)
        }
        return mutableAttributedString
    }
    
    func customizeLabelWhenError() {
        textColor = UIColor.pinkishRed
        isHidden = false
    }
    
    func customizeLabelWhenValid() {
        textColor = UIColor.chestnut
        isHidden = false
    }
    
    func addTagGesture(_ tap:UITapGestureRecognizer) {
        isUserInteractionEnabled = true
        addGestureRecognizer(tap)
    }
    
}

extension UITextField {
    
    func isEmpty() -> Bool {
        return (text == nil || text == "" || text == " ")
    }
    
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
        if(isSecureTextEntry){
            button.setImage(UIImage(named: ""), for: .normal)
        }else{
            button.setImage(UIImage(named: "Icon feather-eye"), for: .normal)
            
        }
    }
    
    func enablePasswordToggle(){
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        button.imageEdgeInsets = UIEdgeInsets(top: -5, left: -16, bottom: 0, right: -5)
        button.frame = CGRect(x: CGFloat(self.frame.size.width - 15), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .always
    }
    
    @IBAction func togglePasswordView(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender as! UIButton)
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}


extension GradientButton {
    
    func customizeButton() {
        self.startColor = UIColor.tangerine
        self.endColor = UIColor.butterscotch
        self.applySketchShadow(color: UIColor.tangerine30, alpha: 1, x: 0, y: 5, blur: 20, spread: 0)
    }
    
    func customizeButtonWhenError() {
        self.startColor = UIColor.scarlet
        self.endColor = UIColor.orangeRed
        self.applySketchShadow(color: UIColor.pinkishRed30, alpha: 1, x: 0, y: 5, blur: 20, spread: 0)
    }
    
    
}


extension UIImageView {
    
    func flipWhenRTL(image: UIImage) {
        switch AppSettings().appLanguage {
        case .EN:
            self.image = image
            break
        default:
            self.image = image.imageFlippedForRightToLeftLayoutDirection()
            break
        }
    }
    
}

//
//  CustomTabbarView.swift
//  MammothTag
//
//  Created by Anwar Hajji on 11/08/2022.
//

import Foundation
import UIKit


enum TabbarItem: String {
    case Home = "Home"
    case Contact = "Contact"
    case Account = "Account"
    
    var selectedItem: Int {
        switch self {
        case .Home:
            return 0
        case .Contact:
            return 1
        case .Account:
            return 2
        }
    }
}

class CustomTabbarView: UIView {
    
    @IBOutlet var viewContent: UIView!
    @IBOutlet weak var homeStackView: UIStackView!
    @IBOutlet weak var homeIcon: UIImageView!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var accountStackView: UIStackView!
    @IBOutlet weak var accountIcon: UIImageView!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var contactIcon: UIImageView!
    @IBOutlet weak var contractStackView: UIStackView!
    @IBOutlet weak var homeSelectedIndicatorView: UIView!
    @IBOutlet weak var ContactSelectedIndicatorView: UIView!
    @IBOutlet weak var accountSelectedIndicatorView: UIView!
    
    var selectedItem = 0 {
        didSet {
            setupSelectedItem(selectedItem: self.selectedItem)
            self.didSelectItem(self.selectedItem)
        }
    }
    
    var didSelectItem : (Int) -> Void = {_ in}
    
    var recognizer: UITapGestureRecognizer {
        get {
            return UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        commonInit()
    }
    
    func setupSelectedItem(selectedItem: Int) {
        if selectedItem == 0 {
            activateItem(indicator: homeSelectedIndicatorView, label: homeLabel, icon: homeIcon)
            deactivateItem(indicator: ContactSelectedIndicatorView, label: contactLabel, icon: contactIcon)
            deactivateItem(indicator: accountSelectedIndicatorView, label: accountLabel, icon: accountIcon)
        } else if selectedItem == 1 {
            activateItem(indicator: ContactSelectedIndicatorView, label: contactLabel, icon: contactIcon)
            deactivateItem(indicator: homeSelectedIndicatorView, label: homeLabel, icon: homeIcon)
            deactivateItem(indicator: accountSelectedIndicatorView, label: accountLabel, icon: accountIcon)
        } else {
            activateItem(indicator: accountSelectedIndicatorView, label: accountLabel, icon: accountIcon)
            deactivateItem(indicator: homeSelectedIndicatorView, label: homeLabel, icon: homeIcon)
            deactivateItem(indicator: ContactSelectedIndicatorView, label: contactLabel, icon: contactIcon)
        }
    }
    
    func activateItem(indicator: UIView, label: UILabel, icon: UIImageView) {
        indicator.backgroundColor = .tangerine
        label.textColor = .tangerine
        icon.changeTintColor(toColor: .tangerine)
    }
    
    func deactivateItem(indicator: UIView, label: UILabel, icon: UIImageView) {
        indicator.backgroundColor = .clear
        label.textColor = .white
        icon.changeTintColor(toColor: .white)
    }
    
    private func commonInit() {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("CustomTabbarView", owner: self, options: nil)
        addSubview(viewContent)
        viewContent.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        viewContent.center = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.5)
        viewContent.layer.backgroundColor = UIColor.clear.cgColor
        homeSelectedIndicatorView.layer.backgroundColor = UIColor.tangerine.cgColor
        ContactSelectedIndicatorView.layer.backgroundColor = UIColor.tangerine.cgColor
        accountSelectedIndicatorView.layer.backgroundColor = UIColor.tangerine.cgColor
        selectedItem = 0
        homeStackView.addTagGesture(recognizer)
        homeStackView.tag = 0
        contractStackView.tag = 1
        accountStackView.tag = 2
        accountStackView.addTagGesture(recognizer)
        contractStackView.addTagGesture(recognizer)
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        guard let tag  = sender?.view?.tag else {return}
        selectedItem = tag
    }
    
}

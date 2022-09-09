//
//  SettingsVC.swift
//  MammothTag
//
//  Created by Anwar Hajji on 09/09/2022.
//

import Foundation
import UIKit

class AppSettingsVC: UIViewController, Storyboarded {
    
    
    
    @IBOutlet weak var arSubView: UIView!
    @IBOutlet weak var arView: UIView!
    @IBOutlet weak var arLbl: UILabel!
    @IBOutlet weak var subviewEnglish: UIView!
    @IBOutlet weak var viewEnglish: UIView!
    @IBOutlet weak var englishLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var selectLangLbl: UILabel!
    
    
    var gesture: UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(updateLanguage(_:)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.flipWhenRTL(image: UIImage(named: "Groupe 469")!)
        selectLangLbl.text = "SELECT_LANGUAGE".localized
        englishLbl.text = "ENGLISH".localized
        arLbl.text =  "ARABIC".localized
        selectLangLbl.font = UIFont(name: "Lato-Black", size: 20)
        arLbl.font = UIFont(name: "Lato-Bold", size: 16)
        englishLbl.font = UIFont(name: "Lato-Bold", size: 16)
        arLbl.tag = 1
        arView.tag = 1
        viewEnglish.tag = 0
        englishLbl.tag = 0
        arLbl.addTagGesture(gesture)
        englishLbl.addTagGesture(gesture)
        arView.addTagGesture(gesture)
        viewEnglish.addTagGesture(gesture)
        customizeView(arView, insideView: arSubView)
        customizeView(viewEnglish, insideView: subviewEnglish)
        if LocalizationSystem.sharedInstance.getLanguage() == "ar" {
            selectView(arView, insideView: arSubView)
            deselectView(viewEnglish, insideView: subviewEnglish)
            selectLangLbl.textAlignment = .right
        } else {
            deselectView(arView, insideView: arSubView)
            selectView(viewEnglish, insideView: subviewEnglish)
            selectLangLbl.textAlignment = .left
        }
    }
    
    @objc func updateLanguage(_ gesture: UITapGestureRecognizer? = nil) {
        if let tag = gesture?.view?.tag {
            if tag == 0 {
                if LocalizationSystem.sharedInstance.getLanguage() == "en" {
                    return
                }
                selectView(arView, insideView: arSubView)
                deselectView(viewEnglish, insideView: subviewEnglish)
                LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
                guard let vc = SpalchScreen.instantiate(storyboardName: "Authentification") else {return}
                let navigationController = UINavigationController(rootViewController: vc)
                let appDlg = UIApplication.shared.delegate as? AppDelegate
                appDlg?.window?.rootViewController = navigationController
            } else {
                if LocalizationSystem.sharedInstance.getLanguage() == "ar" {
                    return
                }
                deselectView(arView, insideView: arSubView)
                selectView(viewEnglish, insideView: subviewEnglish)
                LocalizationSystem.sharedInstance.setLanguage(languageCode: "ar")
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
                guard let vc = SpalchScreen.instantiate(storyboardName: "Authentification") else {return}
                let navigationController = UINavigationController(rootViewController: vc)
                let appDlg = UIApplication.shared.delegate as? AppDelegate
                appDlg?.window?.rootViewController = navigationController
            }
        }
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
    
    
    
    @IBAction func backBtnDidTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

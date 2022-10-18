//
//  ViewController.swift
//  MammothTag
//
//  Created by Anwar Hajji on 07/08/2022.
//

import UIKit

class SpalchScreen: UIViewController, Storyboarded {
    
    
    @IBOutlet weak var mamouthImage: UIImageView!
    
    @IBOutlet weak var mamouthIconHeightConstarinte: NSLayoutConstraint!
    
    @IBOutlet weak var mamouthIconWidthConstarinte: NSLayoutConstraint!
    
    @IBOutlet weak var mamouthIconYposition: NSLayoutConstraint!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    @IBOutlet weak var versionLbl: UILabel!
    
    var originalTransform = CGAffineTransform()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originalTransform = mamouthImage.transform
        descriptionLbl.alpha = 0
        descriptionLbl.text = "WELCOMELABEL".localized
        versionLbl.text = "SIGNIN_DESCRIPTION_LABEL".localized
        versionLbl.alpha = 0
        descriptionLbl.font = UIFont(name: "Lato-Bold", size: 17)
        versionLbl.font = UIFont(name: "Lato-Regular", size: 15)
    }
    
    func checkUpdates() {
        AuthenticationService.sharedInstance.checkAppUpdateAvailability { status in
            if status  {
                self.showAlertWithOk(withTitle: "NEW_UPDATE".localized, withMessage: "NEW_UPDATE_MESSAGE".localized) {
                    if let token = AccountManager.shared.token , !token.isEmptyString {
                        Router.shared.push(with: self.navigationController, screen: .Tabbar, animated: true)
                    } else {
                        Router.shared.push(with: self.navigationController, screen: .Login(sourceController: 0), animated: true)
                    }
                    if let url = URL(string: "https://apps.apple.com/us/app/mammothtag/id1643783069") {
                        UIApplication.shared.open(url)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.animateImage {
                        self.translateImage {
                            self.showLabels {
                                self.hideLabel {
                                    if let token = AccountManager.shared.token , !token.isEmptyString {
                                        Router.shared.push(with: self.navigationController, screen: .Tabbar, animated: true)
                                    } else {
                                        Router.shared.push(with: self.navigationController, screen: .Login(sourceController: 0), animated: true)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } onError: { status in
            DispatchQueue.main.async {
                self.animateImage {
                    self.translateImage {
                        self.showLabels {
                            self.hideLabel {
                                if let token = AccountManager.shared.token , !token.isEmptyString {
                                    Router.shared.push(with: self.navigationController, screen: .Tabbar, animated: true)
                                } else {
                                    Router.shared.push(with: self.navigationController, screen: .Login(sourceController: 0), animated: true)
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        checkUpdates()
        
    }
    
    func animateImage(onFinished: @escaping() -> ()) {
        let scaledTransform = originalTransform.scaledBy(x: 0.7, y: 0.7)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            self.mamouthImage.transform = scaledTransform
        } completion: { _ in
            onFinished()
        }
    }
    
    func translateImage(onFinished: @escaping () -> ()) {
        let scaledTransform = originalTransform.scaledBy(x: 0.4, y: 0.4)
        let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: -140)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            self.mamouthImage.transform = scaledAndTranslatedTransform
            self.descriptionLbl.transform = CGAffineTransform(translationX: 0, y: -120)
            self.versionLbl.transform = CGAffineTransform(translationX: 0, y: -130)
        } completion: { _ in
            onFinished()
        }
    }
    
    func showLabels(onFinished:@escaping () -> ()) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            self.descriptionLbl.alpha = 1
            self.versionLbl.alpha = 1
        } completion: { _ in
            onFinished()
        }
    }
    
    func hideLabel(onFinished:@escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
                self.descriptionLbl.frame.origin.x = self.view.frame.maxX  + 100
                self.versionLbl.frame.origin.x = self.view.frame.maxX  + 100
                self.mamouthImage.frame.origin.x  = self.view.frame.minX  - 100
            } completion: { _ in
                onFinished()
            }
        }
    }
    
    
}



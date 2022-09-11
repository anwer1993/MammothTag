//
//  TermsAndConditionViewController.swift
//  MammothTag
//
//  Created by Anwar Hajji on 10/08/2022.
//

import Foundation
import UIKit

class TermsAndConditionViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var aboutUsTitleLbl: UILabel!
    @IBOutlet weak var privacyTitleLbl: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackViwContainer: UIStackView!
    @IBOutlet weak var firstLabel: UILabel!
    
    @IBOutlet weak var aboutUsStack: UIStackView!
    
    @IBOutlet weak var aboutUsLbl: UILabel!
    
    var termsAndConditionsViewModel = TermsAndConditionsViewModel()
    var source: SourceController?
    var isDone = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupLocalizedText() {
        if source == .FromSettings {
            termsLabel.text = "ABOUT_US".localized
            aboutUsTitleLbl.text = "ABOUT_MAMMOTH".localized
            scrollView.isHidden = true
            aboutUsStack.isHidden = false
        } else {
            termsLabel.text = "PRIVACY".localized
            privacyTitleLbl.text = "PRIVACY".localized
            scrollView.isHidden = false
            aboutUsStack.isHidden = true
        }
        privacyTitleLbl.font = UIFont(name: "Lato-Black", size: 22)
        privacyTitleLbl.textColor = .redBrown
        termsLabel.font = UIFont(name: "Lato-Black", size: 22)
        aboutUsTitleLbl.font = UIFont(name: "Lato-Black", size: 22)
        firstLabel.font = UIFont(name: "Lato-Regular", size: 16)
        aboutUsLbl.font = UIFont(name: "Lato-Regular", size: 16)
        backButton.flipWhenRTL(image: UIImage(named: "Groupe 469")!)
    }
    
    func initView() {
        self.navigationController?.isNavigationBarHidden = true
        setupLocalizedText()
        termsLabel.textColor = UIColor.chestnut
        firstLabel.textColor = UIColor.black
    }
    

    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

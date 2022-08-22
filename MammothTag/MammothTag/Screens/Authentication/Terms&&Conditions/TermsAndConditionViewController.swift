//
//  TermsAndConditionViewController.swift
//  MammothTag
//
//  Created by Anwar Hajji on 10/08/2022.
//

import Foundation
import UIKit

class TermsAndConditionViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackViwContainer: UIStackView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var whyDoUseLabel: UILabel!
    @IBOutlet weak var whyDoesDescLbl: UILabel!
    @IBOutlet weak var whereDoesTitleLbl: UILabel!
    
    var termsAndConditionsViewModel = TermsAndConditionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        termsAndConditionsViewModel.bindViewModelDataToController = {[weak self] done, settingsModel, message in
            guard let this = self else {return}
            this.showOrHideLoader(done: true)
            this.initView()
            this.updateUIWhenGetTermsAndConditionn(done: done, settingsModel: settingsModel, message: message)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showOrHideLoader(done: false)
        termsAndConditionsViewModel.getTerms()
    }
    
    func setupLocalizedText() {
        termsLabel.text = "PRIVACY".localized
        firstLabel.text = "WHY_DO_USE_IT".localized
        whereDoesTitleLbl.text = "WHERE_DOES_IT_COME".localized
        backButton.flipWhenRTL(image: UIImage(named: "Groupe 469")!)
    }
    
    func initView() {
        self.navigationController?.isNavigationBarHidden = true
        setupLocalizedText()
        termsLabel.textColor = UIColor.chestnut
        firstLabel.textColor = UIColor.tangerine
        whereDoesTitleLbl.textColor = .tangerine
    }
    
    func updateUIWhenGetTermsAndConditionn(done: Bool, settingsModel: SettingsModel?, message: String) {
        if done {
            if let settingsModel = settingsModel {
                whyDoUseLabel.text = settingsModel.terms
                whyDoesDescLbl.text = settingsModel.terms
            }
        } else {
            showAlertWithOk(withTitle: "Error", withMessage: message) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

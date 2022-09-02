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
    
    var termsAndConditionsViewModel = TermsAndConditionsViewModel()
    var source: SourceController?
    var isDone = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        termsAndConditionsViewModel.bindViewModelDataToController = {[weak self] done, settingsModel, message in
            guard let this = self else {return}
            this.isDone = true
            this.showOrHideLoader(done: true)
            this.initView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupLocalizedText() {
        if source == .FromSettings {
            termsLabel.text = "About Us"
        } else {
            termsLabel.text = "PRIVACY".localized
            firstLabel.text = ""
        }
        
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

//
//  HomeViewController.swift
//  MammothTag
//
//  Created by Anwar Hajji on 11/08/2022.
//

import UIKit
import CoreNFC

class HomeViewController: UIViewController {
    
    
    @IBOutlet var viewContainer: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var moreView: UIView!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var activateNFCImage: UIImageView!
    @IBOutlet weak var activateNFCLabel: UILabel!
    @IBOutlet weak var digitalCardLabel: UILabel!
    @IBOutlet weak var priviligeDropDownIcon: UIImageView!
    @IBOutlet weak var privilageLabl: UILabel!
    @IBOutlet weak var privilageView: UIView!
    @IBOutlet weak var stackViewOfSelectedScreen: UIStackView!
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var customSegmentControlView: CustomSegmentControlView!
    @IBOutlet weak var socialMediaLabel: UILabel!
    @IBOutlet weak var addSocialeMediaImage: UIImageView!
    @IBOutlet weak var addSocialeMediaLabel: UILabel!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var topBgImage: UIImageView!
    
    let profileModeVC = UpdateProfileModeVC(nibName: "UpdateProfileModeVC", bundle: nil)
    let scanNFCVC = ScanNFCVC(nibName: "ScanNFCVC", bundle: nil)
    let moreVC = MoreVC(nibName: "MoreVC", bundle: nil)
    let addNewCardVC = AddNewCardVc(nibName: "AddNewCardVc", bundle: nil)
    
    var scanNFCGesture: UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(showScanNFCPopup(_:)))
    }
    
    var detectedMessages = [NFCNDEFMessage]()
    var session: NFCNDEFReaderSession?
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        let profileModeTap = UITapGestureRecognizer(target: self, action: #selector(updateProfileMode(_:)))
        privilageView.addTagGesture(profileModeTap)
        let AddCardTap = UITapGestureRecognizer(target: self, action: #selector(showAddCardPopup(_:)))
        addView.addTagGesture(AddCardTap)
        activateNFCImage.addTagGesture(scanNFCGesture)
        activateNFCLabel.addTagGesture(scanNFCGesture)
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let screenWidth = UIScreen.main.bounds.width - 20
        let frame = CGRect(x: 0, y: 0, width: screenWidth, height: customSegmentControlView.bounds.height)
        let view = CustomSegmentControlView(frame: frame)
        self.customSegmentControlView.addSubview(view)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        CardService.shared.getCards(token: AccountManager.shared.token!) { response in
            
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    func initView() {
        privilageLabl.text = AccountManager.shared.profileMode == .Public ? "Public" : "Private"
        customSegmentControlView.layer.cornerRadius = 25.0
        customSegmentControlView.applySketchShadow(color: .black9, alpha: 0.9, x: 0, y: 2, blur: 20, spread: 0)
        moreView.layer.cornerRadius = moreView.bounds.width * 0.5
        privilageView.layer.cornerRadius = 15.0
        privilageView.layer.borderColor = UIColor.white.cgColor
        privilageView.layer.borderWidth = 1
        homeView.layer.cornerRadius = homeView.bounds.width * 0.5
        accountView.layer.cornerRadius = accountView.bounds.width * 0.5
        contactView.layer.cornerRadius = contactView.bounds.width * 0.5
        addView.layer.cornerRadius = addView.bounds.width * 0.5
        addView.layer.backgroundColor = UIColor.redBrown.cgColor
        socialMediaLabel.textColor = .tangerine
        addSocialeMediaLabel.textColor = .brownishGrey
        activateNFCLabel.textColor = .white80
    }
    
    
    @objc func updateProfileMode(_ gesture: UITapGestureRecognizer? = nil) {
        viewContainer.addBlurEffect()
        showProfileModeMenu()
    }
    
    @objc func showAddCardPopup(_ gesture: UITapGestureRecognizer? = nil) {
        viewContainer.addBlurEffect()
        self.tabBarController?.tabBar.isHidden = true
        addNewCardVC.handleTapWhenSave = { card, selectedType in
            self.viewModel.cardName = card
            self.viewModel.cardTyp = CardTypeEnum(rawValue: selectedType) ?? .Digital
            if self.viewModel.validateCardName() {
                self.viewModel.addCard()
            } else {
                self.showAlertWithOk(withTitle: "Error", withMessage: "Please enter the card name")
            }
            
        }
        addChildVc(addNewCardVC) {
            [weak self] in
            guard let this = self else {return}
            this.updateUIWhenRemovePopup()
        }
    }
    
    @objc func showScanNFCPopup(_ gesture: UITapGestureRecognizer? = nil) {
        guard NFCNDEFReaderSession.readingAvailable else {
            let alertController = UIAlertController(
                title: "Scanning Not Supported",
                message: "This device doesn't support tag scanning.",
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        viewContainer.addBlurEffect()
        showScanNFCPopup()
        session?.begin()
    }
    
    func showProfileModeMenu() {
        addChildVc(profileModeVC) {
            [weak self] in
            guard let this = self else {return}
            this.updateUIWhenRemovePopup()
            this.privilageLabl.text = AccountManager.shared.profileMode == .Public ? "Public" : "Private"
        }
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func showScanNFCPopup() {
        addChildVc(scanNFCVC) {[weak self] in
            guard let this = self else {return}
            this.updateUIWhenRemovePopup()
        }
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func updateUIWhenRemovePopup() {
        self.viewContainer.removeBlur()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    @IBAction func moreBtnDidTapped(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = true
        viewContainer.addBlurEffect()
        addChildVc(moreVC) {[weak self] in
            guard let this = self else {return}
            this.updateUIWhenRemovePopup()
        }
    }
    
}


extension HomeViewController: NFCNDEFReaderSessionDelegate {
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        
    }
    
    
}

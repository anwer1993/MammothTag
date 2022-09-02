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
    @IBOutlet weak var socialMediaTable: UITableView!
    
    
    
    let profileModeVC = UpdateProfileModeVC(nibName: "UpdateProfileModeVC", bundle: nil)
    let scanNFCVC = ScanNFCVC(nibName: "ScanNFCVC", bundle: nil)
    let moreVC = MoreVC(nibName: "MoreVC", bundle: nil)
    let addNewCardVC = AddNewCardVc(nibName: "AddNewCardVc", bundle: nil)
    let socialMediaVC =  SocialMediaVC(nibName: "SocialMediaVC", bundle: nil)
    let addSocialMediaVc = AddSocialMediaVc(nibName: "AddSocialMediaVc", bundle: nil)
    
    var scanNFCGesture: UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(showScanNFCPopup(_:)))
    }
    
    var detectedMessages = [NFCNDEFMessage]()
    var session: NFCNDEFReaderSession?
    
    var cardList = [DatumCard]()
    var listCardNetwork = [DatumListCardNetwork]()
    var selectedCard: DatumCard?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        collectionHeight.constant = 0
        self.navigationController?.isNavigationBarHidden = true
        socialMediaTable.delegate = self
        socialMediaTable.dataSource = self
        socialMediaTable.isEditing = true
        socialMediaTable.tableFooterView = UIView()
        let profileModeTap = UITapGestureRecognizer(target: self, action: #selector(updateProfileMode(_:)))
        privilageView.addTagGesture(profileModeTap)
        let AddCardTap = UITapGestureRecognizer(target: self, action: #selector(showAddCardPopup(_:)))
        addView.addTagGesture(AddCardTap)
        activateNFCImage.addTagGesture(scanNFCGesture)
        activateNFCLabel.addTagGesture(scanNFCGesture)
        let AddshowSocialTap = UITapGestureRecognizer(target: self, action: #selector(showSocialMediaList(_:)))
        addSocialeMediaImage.addTagGesture(AddshowSocialTap)
        initView()
        configMoreVC()
        configSocialMediaVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let screenWidth = UIScreen.main.bounds.width - 20
        let frame = CGRect(x: 0, y: 0, width: screenWidth, height: customSegmentControlView.bounds.height)
        let view = CustomSegmentControlView(frame: frame)
        self.customSegmentControlView.addSubview(view)
        
        getData()
    }
    
    func configMoreVC() {
        moreVC.handleDeleteTap = {
            self.handleDeleteTap()
        }
        moreVC.handleShowCardTap = {
            self.handleShowCardListTap()
        }
        moreVC.handleRenameCard = {
            self.handleRenameCard()
        }
        moreVC.handleAddCard = {
            self.showAddCardPopup()
        }
    }
    
    func configSocialMediaVC() {
        socialMediaVC.handleSelectsocialMediaAction = { selectedNetwork in
            self.viewContainer.addBlurEffect()
            self.tabBarController?.tabBar.isHidden = true
            self.addSocialMediaVc.selectedCard = self.selectedCard
            self.addSocialMediaVc.socialMediaID = selectedNetwork
            self.addSocialMediaVc.handleAddSocialMediaAction = { resp in
                if let done = resp?.result, let message = resp?.message {
                    if done {
                        self.getData()
                    } else {
                        self.showAlertWithOk(withTitle: "Error", withMessage: message)
                    }
                } else {
                    self.showAlertWithOk(withTitle: "Error", withMessage: "An error occured please try again")
                }
            }
            self.addChildVc(self.addSocialMediaVc) {
                [weak self] in
                guard let this = self else {return}
                this.updateUIWhenRemovePopup()
            }
        }
    }
    
    func updateUIWhenAddCard(done: Bool, message: String) {
        addNewCardVC.removeView()
        if done {
            getData()
        } else if done == false && message == "Fail" {
            showAlertWithOk(withTitle: "Error", withMessage: "An error occured please try again")
        } else {
            showAlertWithOk(withTitle: "Error", withMessage: message)
        }
    }
    
    func updateUIWhenGetCard(done: Bool, message: String, cards: [DatumCard]?) {
        if done && cards != nil {
            cardList = cards!
            if selectedCard == nil {
                selectedCard = cards!.first
                privilageLabl.text = cards!.first?.name ?? "Unknown card"
            } else {
                selectedCard = cards!.first(where: {$0.id == selectedCard?.id})
                privilageLabl.text = selectedCard?.name ?? "Unknown card"
            }
            profileModeVC.cards = cards!
            profileModeVC.updateUIWhenSelectCard = { card in
                self.updateSelectedCard(selectedCard: card)
            }
            profileModeVC.updateUIWhenDeleteCard = { card in
                self.updateSelectedCard(selectedCard: card)
            }
            profileModeVC.updateUIWhenDeleteCard = { card in
                self.deleteCard(card: card)
            }
            privilageView.isHidden = cards!.count == 0
        } else if done == false && message == "Fail" {
            showAlertWithOk(withTitle: "Error", withMessage: "An error occured please try again")
            privilageView.isHidden = true
        } else {
            showAlertWithOk(withTitle: "Error", withMessage: message)
            privilageView.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    func initView() {
        privilageView.isHidden = true
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
    
    func updateSelectedCard(selectedCard: DatumCard) {
        self.selectedCard = selectedCard
        privilageLabl.text = selectedCard.name
        getData()
    }
    
    func deleteCard(card: DatumCard) {
        deleteCarde(card: card)
    }
    
    func updateUIDeleteCared(Done: Bool, message: String) {
        if Done {
            getData()
        } else {
            showAlertWithOk(withTitle: "Error", withMessage: message)
        }
    }
    
    @objc func updateProfileMode(_ gesture: UITapGestureRecognizer? = nil) {
        viewContainer.addBlurEffect()
        showProfileModeMenu()
    }
    
    func handleDeleteTap () {
        profileModeVC.isDeleteAction = true
        viewContainer.addBlurEffect()
        showProfileModeMenu()
    }
    
    func handleShowCardListTap() {
        profileModeVC.isDeleteAction = false
        viewContainer.addBlurEffect()
        showProfileModeMenu()
    }
    
    func handleRenameCard() {
        addNewCardVC.card = selectedCard
        addNewCardVC.isUpdateAction = true
        AddCardPopup()
    }
    
    func AddCardPopup() {
        viewContainer.addBlurEffect()
        self.tabBarController?.tabBar.isHidden = true
        addNewCardVC.handleTapWhenSave = { card, selectedType in
            if !card.isEmptyString {
                if self.addNewCardVC.isUpdateAction == true {
                    let cardd: DatumCard = DatumCard(id: self.selectedCard?.id, userID: self.selectedCard?.userID, name: card, type: selectedType, privacy: CardPrivacy.Public.rawValue, createdAt: self.selectedCard?.updatedAt, updatedAt: self.selectedCard?.createdAt)
                    self.editCard(card: cardd)
                } else {
                    self.addCard(cardName: card, cardType: selectedType, cardPrivacy: CardPrivacy.Public.rawValue)
                }
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
    
    
    
    @objc func showAddCardPopup(_ gesture: UITapGestureRecognizer? = nil) {
        addNewCardVC.isUpdateAction = false
        addNewCardVC.card = nil
        AddCardPopup()
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
    
    @objc func showSocialMediaList(_ gesture: UITapGestureRecognizer? = nil) {
        viewContainer.addBlurEffect()
        addChildVc(socialMediaVC) {[weak self] in
            guard let this = self else {return}
            this.updateUIWhenRemovePopup()
        }
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func showProfileModeMenu() {
        addChildVc(profileModeVC) {
            [weak self] in
            guard let this = self else {return}
            this.updateUIWhenRemovePopup()
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

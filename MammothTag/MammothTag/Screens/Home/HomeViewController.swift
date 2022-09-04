//
//  HomeViewController.swift
//  MammothTag
//
//  Created by Anwar Hajji on 11/08/2022.
//

import UIKit
import CoreNFC

class HomeViewController: UIViewController {
    
    
    
    @IBOutlet weak var openFirstLbl: UILabel!
    @IBOutlet weak var shareAllLbl: UILabel!
    @IBOutlet weak var openFirstVieew: UIView!
    @IBOutlet weak var shareAllView: UIView!
    @IBOutlet weak var customSegmentStack: UIStackView!
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
    @IBOutlet weak var customSegmentControlView: UIView!
    @IBOutlet weak var socialMediaLabel: UILabel!
    @IBOutlet weak var addSocialeMediaImage: UIImageView!
    @IBOutlet weak var addSocialeMediaLabel: UILabel!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var topBgImage: UIImageView!
    @IBOutlet weak var socialMediaTable: UITableView!
    
    @IBOutlet weak var privilageCard: UIView!
    
    @IBOutlet weak var cardPricilageIcon: UIImageView!
    @IBOutlet weak var privilageLbl: UILabel!
    
    let profileModeVC = UpdateProfileModeVC(nibName: "UpdateProfileModeVC", bundle: nil)
    let scanNFCVC = ScanNFCVC(nibName: "ScanNFCVC", bundle: nil)
    let moreVC = MoreVC(nibName: "MoreVC", bundle: nil)
    let addNewCardVC = AddNewCardVc(nibName: "AddNewCardVc", bundle: nil)
    let socialMediaVC =  SocialMediaVC(nibName: "SocialMediaVC", bundle: nil)
    let addSocialMediaVc = AddSocialMediaVc(nibName: "AddSocialMediaVc", bundle: nil)
    let privilageCardVc = PrivilageCardView(nibName: "PrivilageCardView", bundle: nil)
    let editNetworkVc = EditNetworkVc(nibName: "EditNetworkVc", bundle: nil)
    
    var scanNFCGesture: UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(showScanNFCPopup(_:)))
    }
    
    var detectedMessages = [NFCNDEFMessage]()
    var session: NFCNDEFReaderSession?
    
    var cardList = [DatumCard]()
    var listCardNetwork = [DatumListCardNetwork]()
    var selectedCard: DatumCard?
    
    var selectedItem: Int = 0 {
        didSet {
            updateMenu()
        }
    }
    
    var recognizer: UITapGestureRecognizer {
        get {
            return UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        socialMediaTable.delegate = self
        socialMediaTable.dataSource = self
        socialMediaTable.isEditing = true
        socialMediaTable.tableFooterView = UIView()
        let profileModeTap = UITapGestureRecognizer(target: self, action: #selector(updateProfileMode(_:)))
        privilageView.addTagGesture(profileModeTap)
        let privilageCardTap = UITapGestureRecognizer(target: self, action: #selector(showPrivilageCardPopup(_:)))
        privilageCard.addTagGesture(privilageCardTap)
        let AddCardTap = UITapGestureRecognizer(target: self, action: #selector(showAddCardPopup(_:)))
        addView.addTagGesture(AddCardTap)
        activateNFCImage.addTagGesture(scanNFCGesture)
        activateNFCLabel.addTagGesture(scanNFCGesture)
        let AddshowSocialTap = UITapGestureRecognizer(target: self, action: #selector(showSocialMediaList(_:)))
        addSocialeMediaImage.addTagGesture(AddshowSocialTap)
        initView()
        configMoreVC()
        configSocialMediaVC()
        styleViews()
        shareAllView.tag = 0
        openFirstVieew.tag = 1
        shareAllView.addTagGesture(recognizer)
        openFirstVieew.addTagGesture(recognizer)
        customSegmentControlView.isHidden = true
    }
    
    private func styleViews() {
        styleView(shareAllView)
        styleView(openFirstVieew)
    }
    
    private func styleView(_ view: UIView) {
        view.layer.cornerRadius = 25.0
        view.layer.backgroundColor = UIColor.tangerine.cgColor
    }
    
    private func updateMenu() {
        if selectedItem == 0 {
            activateItem(view: shareAllView, label: shareAllLbl)
            deactivateItem(view: openFirstVieew, label: openFirstLbl)
        } else {
            deactivateItem(view: shareAllView, label: shareAllLbl)
            activateItem(view: openFirstVieew, label: openFirstLbl)
        }
       
    }
    
    private func activateItem(view: UIView, label: UILabel) {
        view.layer.cornerRadius = 25.0
        view.layer.backgroundColor = UIColor.tangerine.cgColor
        label.textColor = .white
    }
    
    private func deactivateItem(view: UIView, label: UILabel) {
        view.layer.backgroundColor = UIColor.white.cgColor
        label.textColor = .brownishGrey
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        guard let tag  = sender?.view?.tag else {return}
        selectedItem = tag
        if tag == 0 {
            publicAllCard(card_id: "\(selectedCard?.id ?? 0)")
        } else {
            if let network = listCardNetwork.first {
                openFirstCard(card_id: network.cardID ?? "", card_network_id: "\(network.id ?? 0)")
            }
            
        }
    }
    
    @objc func showPrivilageCardPopup(_ gesture: UITapGestureRecognizer? = nil) {
        self.viewContainer.addBlurEffect()
        self.tabBarController?.tabBar.isHidden = true
        privilageCardVc.selectedMode = Int(selectedCard?.privacy ?? "1") ?? 1
        privilageCardVc.handleTapWhenSave = { selectedMode in
            let card = DatumCard(id: self.selectedCard?.id, userID: self.selectedCard?.userID, name: self.selectedCard?.name, type: self.selectedCard?.type, privacy: selectedMode, createdAt: self.selectedCard?.createdAt, updatedAt: self.selectedCard?.updatedAt)
            self.privilageCardVc.removeView()
            self.editCard(card: card)
        }
        addChildVc(privilageCardVc) {
            [weak self] in
            guard let this = self else {return}
            this.updateUIWhenRemovePopup()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let screenWidth = UIScreen.main.bounds.width - 20
//        let frame = CGRect(x: 0, y: 0, width: screenWidth, height: customSegmentControlView.bounds.height)
//        let view = CustomSegmentControlView(frame: frame)
//        self.customSegmentControlView.addSubview(view)
        getData()
//        publicAllCard(card_id: "\(selectedCard?.id ?? 0)")
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
                privilageLbl.text = CardPrivacy(rawValue: cards!.first?.privacy ?? "")?.rowValue ?? ""
            } else {
                selectedCard = cards!.first(where: {$0.id == selectedCard?.id})
                privilageLabl.text = selectedCard?.name ?? "Unknown card"
                privilageLbl.text = CardPrivacy(rawValue: selectedCard?.privacy ?? "")?.rowValue ?? ""
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
            privilageCard.isHidden = cards!.count == 0
        } else if done == false && message == "Fail" {
            showAlertWithOk(withTitle: "Error", withMessage: "An error occured please try again")
            privilageView.isHidden = true
            privilageCard.isHidden = true
        } else {
            showAlertWithOk(withTitle: "Error", withMessage: message)
            privilageView.isHidden = true
            privilageCard.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    func initView() {
        privilageView.isHidden = true
        privilageCard.isHidden = true
        customSegmentControlView.layer.cornerRadius = 25.0
        customSegmentControlView.applySketchShadow(color: .black9, alpha: 0.9, x: 0, y: 2, blur: 20, spread: 0)
        moreView.layer.cornerRadius = moreView.bounds.width * 0.5
        privilageView.layer.cornerRadius = 15.0
        privilageView.layer.borderColor = UIColor.white.cgColor
        privilageView.layer.borderWidth = 1
        privilageCard.layer.cornerRadius = 15.0
        privilageCard.layer.borderColor = UIColor.white.cgColor
        privilageCard.layer.borderWidth = 1
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

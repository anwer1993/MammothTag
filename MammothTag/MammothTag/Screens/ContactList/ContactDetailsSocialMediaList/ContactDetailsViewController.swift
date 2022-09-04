//
//  ContactDetailsViewController.swift
//  MammothTag
//
//  Created by Anwar Hajji on 01/09/2022.
//

import UIKit

class ContactDetailsViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var viewProfileImage: UIView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var profileNameLbl: UILabel!
    @IBOutlet weak var socielMediaCollectionView: UICollectionView!
    @IBOutlet weak var selectedCardView: UIView!
    @IBOutlet weak var selectedCardName: UILabel!
    @IBOutlet weak var showCardsIcon: UIImageView!
    
    @IBOutlet weak var emptyListLbl: UILabel!
    
    
    @IBOutlet weak var selectCardPopup: UIView!
    
    @IBOutlet weak var viewControl: UIControl!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var closseBtn: UIButton!
    
    @IBOutlet weak var blurView: UIView!
    
    
    @IBOutlet weak var cardsTableView: UITableView!
    var cardNetworkList: [CardNetwork] = []
    var userData: DataClassUser?
    var user_id = ""
    var cards: [Card] = []
    var selectedCard: Card?
    let profileModeVC = UpdateProfileModeVC(nibName: "UpdateProfileModeVC", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        profileNameLbl.text = "\(userData?.name ?? "") \(userData?.username ?? "")"
        emailLbl.text = userData?.email
        selectCardPopup.isHidden  = true
        self.blurView.isHidden = true
        self.blurView.addBlurEffect()
        emptyListLbl.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(showCardsList(_:)))
        selectedCardView.addTagGesture(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUser()
    }
    
    @objc func showCardsList(_ gesture: UITapGestureRecognizer? = nil) {
        selectCardPopup.isHidden = false
        self.blurView.isHidden = false
    }
    
    func setupUI() {
        viewProfileImage.layer.cornerRadius = 40
        profileImage.layer.cornerRadius = 40
        socielMediaCollectionView.delegate = self
        socielMediaCollectionView.dataSource = self
        let image = UIImage(named: "Groupe 469")?.withRenderingMode(.alwaysTemplate)
        backBtn.setImage(image, for: .normal)
        backBtn.tintColor = UIColor.white
        selectedCardView.layer.cornerRadius = 15.0
        selectedCardView.layer.borderColor = UIColor.white.cgColor
        selectedCardView.layer.borderWidth = 1
        titleLbl.textColor = .redBrown
        viewControl.addTarget(self, action: #selector(removeView(_:)), for: .touchUpInside)
        viewControl.alpha = 0.5
        closseBtn.layer.cornerRadius = closseBtn.frame.width * 0.5
        menuView.layer.cornerRadius = 30.0
        menuView.layer.maskedCorners = [.layerMaxXMinYCorner]
        let cell = UINib(nibName: "SeettingsTableViewCell", bundle: nil)
        cardsTableView.register(cell, forCellReuseIdentifier: "SeettingsTableViewCell")
        cardsTableView.delegate = self
        cardsTableView.dataSource = self
        cardsTableView.tableFooterView = UIView()
        profileNameLbl.font = UIFont(name: "Lato-Black", size: 18)
        titleLbl.font = UIFont(name: "Lato-Black", size: 18)
        titleLbl.textColor = .redBrown
        profileNameLbl.textColor = .tangerine
        emailLbl.font = UIFont(name: "Lato-Regular", size: 14)
        emailLbl.textColor = .white
        emptyListLbl.font = UIFont(name: "Lato-Black", size: 18)
        selectedCardName.font = UIFont(name: "Lato-Black", size: 18)
    }
    
    /// remove view from this view controller
    @objc func removeView(_ gesture: UIGestureRecognizer) {
        selectCardPopup.isHidden = true
        self.blurView.isHidden = true
    }
    
    @IBAction func closeBtnDidTapped(_ sender: Any) {
        selectCardPopup.isHidden = true
        self.blurView.isHidden = true
    }
    
    @IBAction func backBtnDidTapped(_ sender: Any) {
        selectCardPopup.isHidden = true
        self.blurView.isHidden = true
        self.navigationController?.popViewController(animated: true)
    }

}


extension ContactDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardNetworkList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactDetailsCollectionViewCell", for: indexPath) as? ContactDetailsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configCell(CardNetwork: cardNetworkList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(3 - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(3))
        return CGSize(width: size, height: size)
    }

    
}


extension ContactDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SeettingsTableViewCell", for: indexPath) as? SeettingsTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.descriptionLabel.text = cards[indexPath.row].name ?? "Unknown"
        cell.dropRightArrowIcon.image = UIImage(named: "arrow-dropright")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedCard = cards[indexPath.row]
        let networks = self.selectedCard?.cardNetworks ?? []
        if networks.contains(where: {$0.isOpenFirst == "1"}) {
            if let item = networks.first(where: {$0.isOpenFirst == "1"}) {
                self.cardNetworkList = [item]
            }
        } else {
            self.cardNetworkList = networks
        }
        self.socielMediaCollectionView.reloadData()
        self.selectedCardName.text = selectedCard?.name ?? ""
        selectCardPopup.isHidden = true
        self.blurView.isHidden = true
    }
    
    
    
}

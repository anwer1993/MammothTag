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
    
    
    @IBOutlet weak var selectCardView: UIView!
    
    @IBOutlet weak var viewControl: UIControl!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var closseBtn: UIButton!
    
    
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUser()
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
    }
    
    /// remove view from this view controller
    @objc func removeView(_ gesture: UIGestureRecognizer) {
        selectCardView.isHidden = true
        self.viewContainer.removeBlur()
    }
    
    
    
    @IBAction func backBtnDidTapped(_ sender: Any) {
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

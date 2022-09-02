//
//  ContactDetailsCardListViewController.swift
//  MammothTag
//
//  Created by Anwar Hajji on 02/09/2022.
//

import UIKit

class ContactDetailsCardListViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var profileImageShadowView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var topViewBackgroundImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var viewProfileImage: UIView!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var profileNameLbl: UILabel!
    
    @IBOutlet weak var infoViewWidthConstarinte: NSLayoutConstraint!
    
    @IBOutlet weak var shadowInffoViewWidthConstarinte: NSLayoutConstraint!

    @IBOutlet weak var cardsTableView: UITableView!
    
    @IBOutlet weak var emptyDisLbl: UILabel!
    
    var user_id = ""
    var userData: DataClassUser?
    var cards: [Card] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emptyDisLbl.isHidden = true
        setupUI()
        // Do any additional setup after loading the view.
        getUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func setupUI() {
        setupTopViewConstarinte()
        shadowView.applySketchShadow(color: .black37, alpha: 1, x: 0, y: 2, blur: 20, spread: 0)
        shadowView.layer.cornerRadius = 60
        TopView.applyRadiusMaskFor(topLeft: 30.0, bottomLeft: 30.0, bottomRight: 30.0, topRight: 70.0)
        profileImageShadowView.layer.cornerRadius = 60
        profileImageShadowView.applySketchShadow(color: .black37, alpha: 1, x: 0, y: 2, blur: 20, spread: 0)
        viewProfileImage.applyRadiusMaskFor(topLeft: 60.0, bottomLeft: 20.0, bottomRight: 20.0, topRight: 60.0)
        cardsTableView.delegate = self
        cardsTableView.dataSource = self
        cardsTableView.tableFooterView = UIView()
    }
    
    func setupTopViewConstarinte() {
        let screenWidth = UIScreen.main.bounds.width
        shadowInffoViewWidthConstarinte.constant = screenWidth > 390 ? 374 : 339
        infoViewWidthConstarinte.constant = screenWidth > 390 ? 375 : 340
        view.layoutIfNeeded()
    }

    @IBAction func backBtnDidTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ContactDetailsCardListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCardsTableViewCell", for: indexPath) as? ContactCardsTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configCell(card: cards[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cardNetworkList = cards[indexPath.row].cardNetworks ?? []
        Router.shared.push(with: self.navigationController, screen: .ContactDetails(cardNetwork: cardNetworkList, userData: userData), animated: true)
    }
    
    
}

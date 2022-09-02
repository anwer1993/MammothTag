//
//  ContactDetailsViewController.swift
//  MammothTag
//
//  Created by Anwar Hajji on 01/09/2022.
//

import UIKit

class ContactDetailsViewController: UIViewController, Storyboarded {
    
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

    @IBOutlet weak var socielMediaCollectionView: UICollectionView!
    @IBOutlet weak var emptyDicLbl: UILabel!
    
    var cardNetworkList: [CardNetwork] = []
    var userData: DataClassUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        socielMediaCollectionView.isHidden = cardNetworkList.isEmpty
        emptyDicLbl.isHidden = !cardNetworkList.isEmpty
        profileNameLbl.text = "\(userData?.name ?? "") \(userData?.username ?? "")"
        emailLbl.text = userData?.email
        if let dob = userData?.birthday?.dateFromString, let age = dob.age {
            ageLbl.text = "\(age)"
        }
        countryLbl.text = "Tunisia"
    }
    
    func setupUI() {
        setupTopViewConstarinte()
        shadowView.applySketchShadow(color: .black37, alpha: 1, x: 0, y: 2, blur: 20, spread: 0)
        shadowView.layer.cornerRadius = 60
        TopView.applyRadiusMaskFor(topLeft: 30.0, bottomLeft: 30.0, bottomRight: 30.0, topRight: 70.0)
        profileImageShadowView.layer.cornerRadius = 60
        profileImageShadowView.applySketchShadow(color: .black37, alpha: 1, x: 0, y: 2, blur: 20, spread: 0)
        viewProfileImage.applyRadiusMaskFor(topLeft: 60.0, bottomLeft: 20.0, bottomRight: 20.0, topRight: 60.0)
        socielMediaCollectionView.delegate = self
        socielMediaCollectionView.dataSource = self
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ContactDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardNetworkList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactDetailsCollectionViewCell", for: indexPath) as? ContactDetailsCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
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

//
//  SocialMediaVC.swift
//  MammothTag
//
//  Created by Anwar Hajji on 28/08/2022.
//

import Foundation
import UIKit

class SocialMediaVC: UIViewController, SubViewConroller{
    
    var handleTapWhenDismiss: () -> Void = {}
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var viewControl: UIControl!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var screenTitle: UILabel!
    
    
    
    
    @IBOutlet weak var fbLbl: UILabel!
    @IBOutlet weak var facebookIcon: UIImageView!
    @IBOutlet weak var facebookStackView: UIStackView!
    
    
    @IBOutlet weak var instagLbl: UILabel!
    @IBOutlet weak var instagramIcon: UIImageView!
    @IBOutlet weak var instagramStackView: UIStackView!
    
    
    @IBOutlet weak var linkedInLbl: UILabel!
    @IBOutlet weak var linkedinIcon: UIImageView!
    @IBOutlet weak var linkedinStack: UIStackView!
    
    
    @IBOutlet weak var paypalLbl: UILabel!
    @IBOutlet weak var paypalIcon: UIImageView!
    @IBOutlet weak var paypallStack: UIStackView!
    
    
    
    @IBOutlet weak var skypeLbl: UILabel!
    @IBOutlet weak var skypeIcon: UIImageView!
    @IBOutlet weak var skypeStack: UIStackView!
    
    
    
    @IBOutlet weak var snapLbl: UILabel!
    @IBOutlet weak var snapchatIcon: UIImageView!
    @IBOutlet weak var snapchatStack: UIStackView!
    
    
    @IBOutlet weak var tiktokLbl: UILabel!
    @IBOutlet weak var tiktokIcon: UIImageView!
    @IBOutlet weak var tiktokStack: UIStackView!
    
    
    @IBOutlet weak var twitchLbl: UILabel!
    @IBOutlet weak var twitchIcon: UIImageView!
    @IBOutlet weak var twitchStack: UIStackView!

    
    @IBOutlet weak var twitterLbl: UILabel!
    @IBOutlet weak var twitterIcon: UIImageView!
    @IBOutlet weak var twitterStack: UIStackView!
    
    
    @IBOutlet weak var gmailLbl: UILabel!
    @IBOutlet weak var gmailStack: UIStackView!
    
    @IBOutlet weak var emailIcon: UIImageView!
    
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var webSiteStack: UIStackView!
    
    @IBOutlet weak var websiteIcon: UIImageView!
    
    
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var youtubeLbl: UILabel!
    @IBOutlet weak var telegramLbl: UILabel!
    @IBOutlet weak var telegramStack: UIStackView!
    
    @IBOutlet weak var telegramIcon: UIImageView!
    
    @IBOutlet weak var faceTimeStack: UIStackView!
    
    @IBOutlet weak var faceTimeLbl: UILabel!
    @IBOutlet weak var faceTimeIcon: UIImageView!
    
    
    @IBOutlet weak var youtubeIcon: UIImageView!
    @IBOutlet weak var youtubeStack: UIStackView!
    
    
    @IBOutlet weak var phoneIcon: UIImageView!
    @IBOutlet weak var phoneStack: UIStackView!
    
    
    
    var tapGesture: UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(selectSocialMedia(_:)))
    }
    
    var handleSelectsocialMediaAction: (Int) -> () = {_ in}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        facebookStackView.addTagGesture(tapGesture)
        instagramStackView.addTagGesture(tapGesture)
        linkedinStack.addTagGesture(tapGesture)
        paypallStack.addTagGesture(tapGesture)
        skypeStack.addTagGesture(tapGesture)
        snapchatStack.addTagGesture(tapGesture)
        tiktokStack.addTagGesture(tapGesture)
        twitchStack.addTagGesture(tapGesture)
        twitterStack.addTagGesture(tapGesture)
        gmailStack.addTagGesture(tapGesture)
        webSiteStack.addTagGesture(tapGesture)
        telegramStack.addTagGesture(tapGesture)
        faceTimeStack.addTagGesture(tapGesture)
        youtubeStack.addTagGesture(tapGesture)
        phoneStack.addTagGesture(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func initView() {
        viewControl.addTarget(self, action: #selector(removeView(_:)), for: .touchUpInside)
        viewControl.alpha = 0.5
        viewContainer.layer.cornerRadius = 20
        viewContainer.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        closeButton.layer.cornerRadius = closeButton.frame.width * 0.5
        linkedinIcon.layer.cornerRadius = linkedinIcon.frame.width * 0.5
        instagramIcon.layer.cornerRadius = linkedinIcon.frame.width * 0.5
        facebookIcon.layer.cornerRadius = linkedinIcon.frame.width * 0.5
        paypalIcon.layer.cornerRadius = paypalIcon.frame.width * 0.5
        skypeIcon.layer.cornerRadius = skypeIcon.frame.width * 0.5
        snapchatIcon.layer.cornerRadius = snapchatIcon.frame.width * 0.5
        tiktokIcon.layer.cornerRadius = tiktokIcon.frame.width * 0.5
        twitchIcon.layer.cornerRadius = twitchIcon.frame.width * 0.5
        twitterIcon.layer.cornerRadius = twitterIcon.frame.width * 0.5
        fbLbl.font = UIFont(name: "Lato-Regular", size: 16)
        instagLbl.font = UIFont(name: "Lato-Regular", size: 16)
        linkedInLbl.font = UIFont(name: "Lato-Regular", size: 16)
        paypalLbl.font = UIFont(name: "Lato-Regular", size: 16)
        skypeLbl.font = UIFont(name: "Lato-Regular", size: 16)
        snapLbl.font = UIFont(name: "Lato-Regular", size: 16)
        tiktokLbl.font = UIFont(name: "Lato-Regular", size: 16)
        twitchLbl.font = UIFont(name: "Lato-Regular", size: 16)
        twitterLbl.font = UIFont(name: "Lato-Regular", size: 16)
        gmailLbl.font = UIFont(name: "Lato-Regular", size: 16)
        websiteLbl.font = UIFont(name: "Lato-Regular", size: 16)
        telegramLbl.font = UIFont(name: "Lato-Regular", size: 16)
        faceTimeLbl.font = UIFont(name: "Lato-Regular", size: 16)
        youtubeLbl.font = UIFont(name: "Lato-Regular", size: 16)
        phoneLbl.font = UIFont(name: "Lato-Regular", size: 16)
        screenTitle.font = UIFont(name: "Lato-Bold", size: 18)
        screenTitle.textColor = .redBrown
    }
    
    func removeView() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
        handleTapWhenDismiss()
    }
    
    
    @objc func removeView(_ gesture: UIGestureRecognizer) {
        removeView()
    }
    
    @IBAction func closeButtonDidTapped(_ sender: Any) {
        removeView()
    }
    
    @objc func selectSocialMedia(_ gesture: UITapGestureRecognizer? = nil) {
        guard let view = gesture?.view else {return}
        let tag = view.tag
        removeView()
        handleSelectsocialMediaAction(tag)
    }
    
}

extension SocialMediaVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Contstant.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SocialMediaCollectionCell", for: indexPath) as? SocialMediaCollectionCell else {
            return UICollectionViewCell()
        }
        cell.image.image = UIImage(named: Contstant.data[indexPath.row].imageName ?? "")
        cell.title.text = Contstant.data[indexPath.row].socialMediaName ?? ""
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let cellWidth = (UIScreen.main.bounds.width - 20) / 3
        return CGSize(width: cellWidth, height: cellWidth);
    }
    
    
}

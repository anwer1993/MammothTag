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
    
    
    
    @IBOutlet weak var screenTitle: UILabel!
    
    
    
    
    @IBOutlet weak var facebookIcon: UIImageView!
    @IBOutlet weak var facebookStackView: UIStackView!
    
    
    @IBOutlet weak var instagramIcon: UIImageView!
    @IBOutlet weak var instagramStackView: UIStackView!
    
    
    @IBOutlet weak var linkedinIcon: UIImageView!
    @IBOutlet weak var linkedinStack: UIStackView!
    
    
    @IBOutlet weak var paypalIcon: UIImageView!
    @IBOutlet weak var paypallStack: UIStackView!
    
    
    
    @IBOutlet weak var skypeIcon: UIImageView!
    @IBOutlet weak var skypeStack: UIStackView!
    
    
    
    @IBOutlet weak var snapchatIcon: UIImageView!
    @IBOutlet weak var snapchatStack: UIStackView!
    
    
    @IBOutlet weak var tiktokIcon: UIImageView!
    @IBOutlet weak var tiktokStack: UIStackView!
    
    
    @IBOutlet weak var twitchIcon: UIImageView!
    @IBOutlet weak var twitchStack: UIStackView!

    
    @IBOutlet weak var twitterIcon: UIImageView!
    @IBOutlet weak var twitterStack: UIStackView!
    
    
    var data: [SocialMediaModel] = [
        SocialMediaModel(imageName: "facebook", socialMediaName: "Facebook", socialMediaId: 1),
        SocialMediaModel(imageName: "ic_platform_instagram", socialMediaName: "Instagram", socialMediaId: 2),
        SocialMediaModel(imageName: "ic_platform_linkin", socialMediaName: "Linkedin", socialMediaId: 3),
        SocialMediaModel(imageName: "ic_platform_paypal", socialMediaName: "Paypal", socialMediaId: 4),
        SocialMediaModel(imageName: "skype", socialMediaName: "Skype", socialMediaId: 5),
        SocialMediaModel(imageName: "ic_platform_snapchat", socialMediaName: "Snapchat", socialMediaId: 6),
        SocialMediaModel(imageName: "ic_platform_tiktok", socialMediaName: "Tiktok", socialMediaId: 7),
        SocialMediaModel(imageName: "pinterest", socialMediaName: "Twitch", socialMediaId: 8),
        SocialMediaModel(imageName: "ic_platform_twitter", socialMediaName: "Twitter", socialMediaId: 9)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func initView() {
        linkedinIcon.layer.cornerRadius = linkedinIcon.frame.width * 0.5
        instagramIcon.layer.cornerRadius = linkedinIcon.frame.width * 0.5
        facebookIcon.layer.cornerRadius = linkedinIcon.frame.width * 0.5
        paypalIcon.layer.cornerRadius = paypalIcon.frame.width * 0.5
        skypeIcon.layer.cornerRadius = skypeIcon.frame.width * 0.5
        snapchatIcon.layer.cornerRadius = snapchatIcon.frame.width * 0.5
        tiktokIcon.layer.cornerRadius = tiktokIcon.frame.width * 0.5
        twitchIcon.layer.cornerRadius = twitchIcon.frame.width * 0.5
        twitterIcon.layer.cornerRadius = twitterIcon.frame.width * 0.5
    }
    
    
}

extension SocialMediaVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SocialMediaCollectionCell", for: indexPath) as? SocialMediaCollectionCell else {
            return UICollectionViewCell()
        }
        cell.image.image = UIImage(named: data[indexPath.row].imageName ?? "")
        cell.title.text = data[indexPath.row].imageName ?? ""
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let cellWidth = (UIScreen.main.bounds.width - 20) / 3
        return CGSize(width: cellWidth, height: cellWidth);
    }
    
    
}

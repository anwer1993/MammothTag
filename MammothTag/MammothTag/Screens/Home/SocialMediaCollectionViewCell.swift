//
//  SocialMediaCollectionViewCell.swift
//  MammothTag
//
//  Created by Anwar Hajji on 30/08/2022.
//

import Foundation
import UIKit

class SocialMediaCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var socialMediaIcon: UIImageView!
    
    @IBOutlet weak var socialMediaLink: UILabel!
    
    func configCell(network: DatumListCardNetwork) {
        socialMediaIcon.layer.cornerRadius = socialMediaIcon.frame.width * 0.5
        socialMediaLink.text = network.link
        switch Int(network.socialNetworkID ?? "") {
        case 1:
            socialMediaIcon.image = UIImage(named: "facebook")!
            break
        case 2:
            socialMediaIcon.image = UIImage(named: "ic_platform_instagram")!
            break
        case 3:
            socialMediaIcon.image = UIImage(named: "ic_platform_linkin")!
            break
        case 4:
            socialMediaIcon.image = UIImage(named: "ic_platform_paypal")!
            break
        case 5:
            socialMediaIcon.image = UIImage(named: "skype")!
            break
        case 6:
            socialMediaIcon.image = UIImage(named: "ic_platform_snapchat")!
            break
        case 7:
            socialMediaIcon.image = UIImage(named: "ic_platform_tiktok")!
            break
        case 8:
            socialMediaIcon.image = UIImage(named: "pinterest")!
            break
        case 9:
            socialMediaIcon.image = UIImage(named: "ic_platform_twitter")!
            break
        default:
            print("non")
            break
        }
    }
    
}

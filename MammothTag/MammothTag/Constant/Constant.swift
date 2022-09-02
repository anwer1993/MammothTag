//
//  Constant.swift
//  MammothTag
//
//  Created by Anwar Hajji on 28/08/2022.
//

import Foundation
import UIKit


protocol contactProtocol {
    func deleteRequest(request: DatumListRequest)
    func acceptRequest(request: DatumListRequest)
    func deleteContact(contact: DatumListContact)
}

class Contstant {
    
    static var faceBookId = "1"
    static var instagramId = "2"
    static var linkedinId = "3"
    static var paypalId = "4"
    static var skypeId = "5"
    static var snapshatId = "6"
    static var tiktokId = "7"
    static var twitchId = "8"
    static var twitterId = "9"
    
    static var data: [SocialMediaModel] = [
        SocialMediaModel(imageName: "facebook", socialMediaName: "Facebook", socialMediaId: 1),
        SocialMediaModel(imageName: "ic_platform_instagram", socialMediaName: "Instagram", socialMediaId: 2),
        SocialMediaModel(imageName: "ic_platform_linkin", socialMediaName: "Linkedin", socialMediaId: 3),
        SocialMediaModel(imageName: "ic_platform_paypal", socialMediaName: "Paypal", socialMediaId: 4),
        SocialMediaModel(imageName: "skype", socialMediaName: "Skype", socialMediaId: 5),
        SocialMediaModel(imageName: "ic_platform_snapchat", socialMediaName: "Snapchat", socialMediaId: 6),
        SocialMediaModel(imageName: "ic_platform_tiktok", socialMediaName: "Tiktok", socialMediaId: 7),
        SocialMediaModel(imageName: "pinterest", socialMediaName: "Twitch", socialMediaId: 8),
        SocialMediaModel(imageName: "ic_platform_twitter", socialMediaName: "Twitter", socialMediaId: 9)]
    
    static func updateRootVC() {
        let status: Bool?
        var rootVC : UIViewController?
        
        if let token = AccountManager.shared.token, !token.isEmptyString {
            status = true
        }else {
            status = false
        }

        if(status == true){
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabbarViewController") as? MainTabbarViewController
        } else{
            rootVC = UIStoryboard(name: "Authentification", bundle: nil).instantiateViewController(withIdentifier: "SpalchScreen") as? SpalchScreen
        }

        guard let root = rootVC else {return }

        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        let nav = UINavigationController(rootViewController: root)
        window?.rootViewController = nav
    }
}

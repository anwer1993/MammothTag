//
//  ContactDetailsCollectionViewCell.swift
//  MammothTag
//
//  Created by Anwar Hajji on 01/09/2022.
//

import UIKit

class ContactDetailsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var socialMMediaLink: UILabel!
    @IBOutlet weak var socialMediaIcon: UIImageView!
    
    func configCell(CardNetwork: CardNetwork) {
        socialMediaIcon.layer.cornerRadius = 30
        socialMMediaLink.text  = CardNetwork.link ?? ""
        let networkIcon = Contstant.data.first(where: {$0.socialMediaId == Int(CardNetwork.socialNetworkID ?? "1") ?? 1})?.imageName ?? ""
        socialMediaIcon.image = UIImage(named: networkIcon)
    }
    
}

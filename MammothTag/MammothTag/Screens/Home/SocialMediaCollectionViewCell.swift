//
//  SocialMediaCollectionViewCell.swift
//  MammothTag
//
//  Created by Anwar Hajji on 30/08/2022.
//

import Foundation
import UIKit

class SocialMediaTableViewCell: UITableViewCell {
    
//    @IBOutlet weak var dragIcon: UIImageView!
    @IBOutlet weak var socialMediaLink: UILabel!
    @IBOutlet weak var socialMediaIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        socialMediaIcon.layer.cornerRadius = socialMediaIcon.frame.width * 0.5
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(network: CardNetworkProfile, selectedItem: Int) {
        let networkIcon = Contstant.data.first(where: {$0.socialMediaId == Int(network.socialNetworkID ?? "1") ?? 1})?.imageName ?? ""
        socialMediaIcon.image = UIImage(named: networkIcon)
        if selectedItem == 1 {
            if network.isOpenFirst == "0" {
                self.contentView.alpha = 0.6
                socialMediaLink.alpha = 0.6
                socialMediaIcon.alpha = 0.6
            } else {
                self.contentView.alpha = 1
                socialMediaLink.alpha = 1
                socialMediaIcon.alpha = 1
            }
        } else {
            self.contentView.alpha = 1
            socialMediaLink.alpha = 1
            socialMediaIcon.alpha = 1
        }
    }
    
}

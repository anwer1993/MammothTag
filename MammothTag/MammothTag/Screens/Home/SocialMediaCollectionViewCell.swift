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
//        contentView.layer.borderWidth = 2
//        contentView.layer.borderColor = UIColor.black.cgColor
//        viewContainer.layer.cornerRadius = 15.0
        socialMediaIcon.layer.cornerRadius = socialMediaIcon.frame.width * 0.5
//        viewContainer.applySketchShadow(color: UIColor.black13, alpha: 0.8, x: 0, y: 2, blur: 20, spread: 0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell() {
        
    }
    
}

//
//  ContactTableViewCell.swift
//  MammothTag
//
//  Created by Anwar Hajji on 11/08/2022.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var contactNameLbl: UILabel!
    @IBOutlet weak var addedDateLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContainer.layer.cornerRadius = 20.0
        viewContainer.applySketchShadow(color: UIColor.black13, alpha: 0.8, x: 0, y: 2, blur: 20, spread: 0)
        contactImage.layer.cornerRadius = contactImage.frame.width * 0.5
        contactNameLbl.textColor = .greyishBrown
        addedDateLbl.textColor = .greyishBrown
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

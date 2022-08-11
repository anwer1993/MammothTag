//
//  SeettingsTableViewCell.swift
//  MammothTag
//
//  Created by Anwar Hajji on 11/08/2022.
//

import UIKit

class SeettingsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var dropRightArrowIcon: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dropRightArrowIcon.flipWhenRTL(image: UIImage(named: "arrow-dropright")!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

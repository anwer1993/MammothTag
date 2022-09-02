//
//  ContactCardsTableViewCell.swift
//  MammothTag
//
//  Created by Anwar Hajji on 02/09/2022.
//

import UIKit

class ContactCardsTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var cardNameLbl: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        icon.flipWhenRTL(image: UIImage(named: "arrow-dropright")!)
        viewContainer.layer.cornerRadius = 15.0
        viewContainer.applySketchShadow(color: UIColor.black13, alpha: 0.8, x: 0, y: 2, blur: 20, spread: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(card: Card) {
        cardNameLbl.text = card.name
    }

}

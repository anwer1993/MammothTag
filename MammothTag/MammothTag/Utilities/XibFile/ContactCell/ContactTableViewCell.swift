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
    
    @IBOutlet weak var addIcon: UIImageView!
    
    var delegate: contactProtocol?
    var selectedItem = 0
    var request: DatumListRequest?
    var contact: DatumListContact?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContainer.layer.cornerRadius = 20.0
        viewContainer.applySketchShadow(color: UIColor.black13, alpha: 0.8, x: 0, y: 2, blur: 20, spread: 0)
        contactImage.layer.cornerRadius = contactImage.frame.width * 0.5
        contactNameLbl.textColor = .greyishBrown
        addedDateLbl.textColor = .greyishBrown
        let deleteAction = UITapGestureRecognizer(target: self, action: #selector(deleteContactOrRequest(_gesture:)))
        let acceptAction = UITapGestureRecognizer(target: self, action: #selector(acceptRequest(_gesture:)))
        deleteIcon.addTagGesture(deleteAction)
        addIcon.addTagGesture(acceptAction)
        contactNameLbl.font = UIFont(name: "Lato-Bold", size: 18)
        addedDateLbl.font = UIFont(name: "Lato-Regular", size: 14)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell(request: DatumListRequest) {
        selectedItem = 1
        self.request = request
        contactNameLbl.text = request.name
        addedDateLbl.text = request.createdAt?.stringFromDate
        addIcon.isHidden = false
    }
    
    func ConfigCellForListContact(contact: DatumListContact) {
        selectedItem = 0
        self.contact = contact
        contactNameLbl.text = contact.name
        addedDateLbl.text = contact.createdAt?.stringFromDate
        addIcon.isHidden = true
//        addedDateLbl.text = ""
    }

    @objc func deleteContactOrRequest(_gesture: UITapGestureRecognizer? = nil) {
        if selectedItem == 0 {
            if let contact = contact {
                delegate?.deleteContact(contact: contact)
            }
        } else {
            if let request = request {
                delegate?.deleteRequest(request: request)
            }
            
        }
    }
    
    @objc func acceptRequest(_gesture: UITapGestureRecognizer? = nil) {
        if let request = request {
            delegate?.acceptRequest(request: request)
        }
    }
    
}

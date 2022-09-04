//
//  MoreVC.swift
//  MammothTag
//
//  Created by Anwar Hajji on 15/08/2022.
//

import Foundation
import UIKit


class MoreVC: UIViewController, SubViewConroller {
    
    
    @IBOutlet weak var addNewCardLbl: UILabel!
    @IBOutlet weak var addNewCardIcon: UIImageView!
    @IBOutlet weak var addNewCardStack: UIStackView!
    @IBOutlet weak var showCardListLbl: UILabel!
    @IBOutlet weak var showCardListIcon: UIImageView!
    @IBOutlet weak var showCardListStack: UIStackView!
    @IBOutlet weak var bottomStackView: UIStackView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var deleteCardLbl: UILabel!
    @IBOutlet weak var deleteCardIcon: UIImageView!
    @IBOutlet weak var deleteCardStack: UIStackView!
    @IBOutlet weak var activateNFCLbl: UILabel!
    @IBOutlet weak var activateNFCIcon: UIImageView!
    @IBOutlet weak var activateNFCStack: UIStackView!
    @IBOutlet weak var renameCardLbl: UILabel!
    @IBOutlet weak var renameCardIcon: UIImageView!
    @IBOutlet weak var renameCardStackView: UIStackView!
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var viewControl: UIControl!
    @IBOutlet var viewContainer: UIView!
    
    var handleTapWhenDismiss: () -> Void = {}
    
    var handleDeleteTap: () -> Void = {}
    
    var handleShowCardTap: () -> Void = {}
    
    var handleRenameCard: () -> Void = {}
    
    var handleAddCard: () -> Void = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func initView() {
        viewControl.addTarget(self, action: #selector(removeView(_:)), for: .touchUpInside)
        viewControl.alpha = 0.5
        closeButton.layer.cornerRadius = closeButton.frame.width * 0.5
        menuView.layer.cornerRadius = 30.0
        menuView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let deleteCardTap = UITapGestureRecognizer(target: self, action: #selector(deleteCard(_:)))
        let showCardListTap = UITapGestureRecognizer(target: self, action: #selector(showCardList(_:)))
        let renammeCardTap = UITapGestureRecognizer(target: self, action: #selector(renameCard(_:)))
        let addCardTap = UITapGestureRecognizer(target: self, action: #selector(addCard(_:)))
        addNewCardStack.addTagGesture(addCardTap)
        deleteCardStack.addTagGesture(deleteCardTap)
        showCardListStack.addTagGesture(showCardListTap)
        renameCardStackView.addTagGesture(renammeCardTap)
        addNewCardLbl.font = UIFont(name: "Lato-SemiBold", size: 16)
        activateNFCLbl.font = UIFont(name: "Lato-SemiBold", size: 16)
        deleteCardLbl.font = UIFont(name: "Lato-SemiBold", size: 16)
        showCardListLbl.font = UIFont(name: "Lato-SemiBold", size: 16)
        addNewCardLbl.font = UIFont(name: "Lato-SemiBold", size: 16)
        addNewCardLbl.text = "ADD_CARD".localized
        showCardListLbl.text = "SHOW_LIST".localized
        renameCardLbl.text = "RENAME_CARD".localized
        deleteCardLbl.text = "DELETE_CARD".localized
    }
    
    @objc func removeView(_ gesture: UIGestureRecognizer) {
        removeView()
    }
    
    @objc func deleteCard(_ gesture: UIGestureRecognizer) {
        removeView()
        handleDeleteTap()
    }
    
    @objc func showCardList(_ gesture: UIGestureRecognizer) {
        removeView()
        handleShowCardTap()
    }
    
    @objc func renameCard(_ gesture: UIGestureRecognizer) {
        removeView()
        handleRenameCard()
    }
    
    @objc func addCard(_ gesture: UIGestureRecognizer) {
        removeView()
        handleAddCard()
    }
    
    func removeView() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
        handleTapWhenDismiss()
    }
    
    @IBAction func closeButtonDidTapped(_ sender: Any) {
        removeView()
    }
    
}

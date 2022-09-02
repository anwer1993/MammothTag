//
//  UpdateProfileModeVC.swift
//  MammothTag
//
//  Created by Anwar Hajji on 12/08/2022.
//

import Foundation
import UIKit

class UpdateProfileModeVC : UIViewController, SubViewConroller {
    
    @IBOutlet weak var viewControl: UIControl!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var selectProfileLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var handleTapWhenDismiss: () -> Void = {}
    var updateProfileeMode: () -> Void = {}
    var updateUIWhenSelectCard: (DatumCard) -> Void = {_ in }
    var updateUIWhenDeleteCard: (DatumCard) -> Void = {_ in }
    
    var selectedMode: Int = 0 {
        didSet {
            updateUIWhenSelectMode()
            
        }
    }
    
    var cards = [DatumCard]()
    var selectedCard: DatumCard?
    var isDeleteAction = false
    
    var tapGesture: UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isDeleteAction {
            selectProfileLbl.text = "Delete card"
        } else {
            selectProfileLbl.text = "Select your card"
        }
        self.tableView.reloadData()
    }
    
    func customizeView(_ view: UIView, insideView: UIView) {
        view.layer.cornerRadius = view.frame.width * 0.5
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.redBrown.cgColor
        insideView.layer.cornerRadius = insideView.frame.width * 0.5
        insideView.layer.backgroundColor = UIColor.redBrown.cgColor
    }
    
    func deselectView(_ view: UIView, insideView: UIView) {
        view.layer.borderColor = UIColor.warmGreyTwo.cgColor
        insideView.isHidden = true
    }
    
    func selectView(_ view: UIView, insideView: UIView) {
        view.layer.borderColor = UIColor.redBrown.cgColor
        insideView.isHidden = false
    }
    
    func initView() {
        selectProfileLbl.textColor = .redBrown
        selectedMode = AccountManager.shared.profileMode?.rawValue ?? 0
        viewControl.addTarget(self, action: #selector(removeView(_:)), for: .touchUpInside)
        viewControl.alpha = 0.5
        downButton.layer.cornerRadius = downButton.frame.width * 0.5
        menuView.layer.cornerRadius = 30.0
        menuView.layer.maskedCorners = [.layerMaxXMinYCorner]
        updateUIWhenSelectMode()
        let cell = UINib(nibName: "SeettingsTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "SeettingsTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func updateUIWhenSelectMode() {
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if let tag = sender?.view?.tag {
            selectedMode = tag
        }
    }
    
    @IBAction func saveBtnDidTapped(_ sender: Any) {
        AccountManager.shared.profileMode = ProfileMode(rawValue: selectedMode)
        removeView()
    }
    
    /// remove view from this view controller
    @objc func removeView(_ gesture: UIGestureRecognizer) {
        removeView()
    }
    
    /// Hide participant list action
    @IBAction func hideMenuView(_ sender: Any) {
        removeView()
    }
    
    /// remove view
    func removeView() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
        isDeleteAction = false
        selectedMode = AccountManager.shared.profileMode?.rawValue ?? 0
        handleTapWhenDismiss()
    }
    
}


extension UpdateProfileModeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SeettingsTableViewCell", for: indexPath) as? SeettingsTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.descriptionLabel.text = cards[indexPath.row].name ?? "Unknown"
        cell.dropRightArrowIcon.image = UIImage(named: isDeleteAction ? "Icon feather-trash-2" : "arrow-dropright")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let selectedCard = selectedCard, selectedCard.id == cards[indexPath.row].id {
            return
        } else {
            if isDeleteAction {
                updateUIWhenDeleteCard(cards[indexPath.row])
            } else {
                updateUIWhenSelectCard(cards[indexPath.row])
            }
            
        }
        removeView()
    }
    
}

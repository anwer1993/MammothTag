//
//  ContactListViewController.swift
//  MammothTag
//
//  Created by Anwar Hajji on 11/08/2022.
//

import UIKit

class ContactListViewController: UIViewController, Storyboarded {

    
    
    @IBOutlet weak var contactListLbl: UILabel!
    @IBOutlet weak var addIcon: UIImageView!
    @IBOutlet weak var contactsTableView: UITableView!
    
    
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var contactLabl: UILabel!
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var segmentStack: UIStackView!
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var requestLabel: UILabel!
    @IBOutlet weak var requestView: UIView!
    
    
    var selectedItem: Int = 0 {
        didSet {
            updateMenu()
            if selectedItem == 0 {
                getContactList()
            } else {
                getRequestList()
            }
        }
    }
    
    var recognizer: UITapGestureRecognizer {
        get {
            return UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        }
    }
    
    var requestList = [DatumListRequest]()
    var contactList = [DatumListContact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupTableView()
        setupLocalizedText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initView()
        if selectedItem == 0 {
            getContactList()
        } else {
            getRequestList()
        }
    }
    
    func setupTableView() {
        let cell = UINib(nibName: "ContactTableViewCell", bundle: nil)
        contactsTableView.register(cell, forCellReuseIdentifier: "ContactTableViewCell")
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        contactsTableView.tableFooterView = UIView()
    }
    
    func setupLocalizedText() {
        contactListLbl.textColor = .chestnut
        contactListLbl.text = "CONTACT_LIST".localized
    }
    
    func initView() {
        segmentView.layer.cornerRadius = 25
        segmentStack.layer.cornerRadius = 25
        segmentView.applySketchShadow(color: .black9, alpha: 0.9, x: 0, y: 2, blur: 20, spread: 0)
        styleView(contactView)
        styleView(requestView)
        selectedItem = 0
        contactView.tag = 0
        requestView.tag = 1
        contactView.addTagGesture(recognizer)
        requestView.addTagGesture(recognizer)
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        guard let tag  = sender?.view?.tag else {return}
        selectedItem = tag
    }
    
    private func styleView(_ view: UIView) {
        view.layer.cornerRadius = 25.0
        view.layer.backgroundColor = UIColor.tangerine.cgColor
    }
    
    private func updateMenu() {
        if selectedItem == 0 {
            activateItem(view: contactView, label: contactLabl)
            deactivateItem(view: requestView, label: requestLabel)
        } else {
            activateItem(view: requestView, label: requestLabel)
            deactivateItem(view: contactView, label: contactLabl)
        }
    }
    
    private func activateItem(view: UIView, label: UILabel) {
        view.layer.cornerRadius = 25.0
        view.layer.backgroundColor = UIColor.tangerine.cgColor
        label.textColor = .white
    }
    
    private func deactivateItem(view: UIView, label: UILabel) {
        view.layer.backgroundColor = UIColor.white.cgColor
        label.textColor = .brownishGrey
    }

}


extension ContactListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedItem == 0 ? contactList.count : requestList.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 110.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as? ContactTableViewCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        cell.delegate = self
        if selectedItem == 0 {
            cell.ConfigCellForListContact(contact: contactList[indexPath.row])
        } else {
            cell.configCell(request: requestList[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedItem == 0 {
            let id = "\(contactList[indexPath.row].id ?? 0)"
            Router.shared.push(with: self.navigationController, screen: .ContactDetails(user_id: id), animated: true)
        }
        
    }
    
    
}

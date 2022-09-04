//
//  ContactListViewController.swift
//  MammothTag
//
//  Created by Anwar Hajji on 11/08/2022.
//

import UIKit

class ContactListViewController: UIViewController, UIGestureRecognizerDelegate,Storyboarded {

    
    
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
    
    var swipeTap = UIPanGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupTableView()
        setupLocalizedText()
        swipeTap = UIPanGestureRecognizer(target: self, action:  #selector(didSwipeAlert(_:)))
        segmentView.isUserInteractionEnabled = true
        swipeTap.delegate = self
        segmentView.addGestureRecognizer(swipeTap)
    }
    
    @objc func didSwipeAlert(_ sender:UIPanGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
            let location = swipeTap.location(in: segmentView)
            print("location", location.x)
            if location.x > segmentView.frame.width * 0.5 {
                if selectedItem != 1 {
                    selectedItem = 1
                }
            } else {
                if selectedItem != 0 {
                    selectedItem = 0
                }
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initView()
        emptyView.isHidden = true
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
        selectedItem = 0
        contactView.tag = 0
        requestView.tag = 1
        contactView.addTagGesture(recognizer)
        requestView.addTagGesture(recognizer)
        contactLabl.font = UIFont(name: "Lato-Bold", size: 16)
        requestLabel.font = UIFont(name: "Lato-Bold", size: 16)
        emptyLabel.font = UIFont(name: "Lato-Black", size: 18)
        contactListLbl.font = UIFont(name: "Lato-Black", size: 18)
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
            requestView.layer.shadowOpacity  = 0
            contactView.applySketchShadow(color: .black37, alpha: 1, x: 0, y: 1, blur: 20, spread: 0)
        } else {
            activateItem(view: requestView, label: requestLabel)
            deactivateItem(view: contactView, label: contactLabl)
            contactView.layer.shadowOpacity  = 0
            requestView.applySketchShadow(color: .black37, alpha: 1, x: 0, y: 2, blur: 20, spread: 0)
        }
    }
    
    private func activateItem(view: UIView, label: UILabel) {
        view.layer.cornerRadius = 25.0
        view.layer.backgroundColor = UIColor.tangerine.cgColor
        label.textColor = .white
    }
    
    private func deactivateItem(view: UIView, label: UILabel) {
        view.layer.backgroundColor = UIColor.clear.cgColor
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

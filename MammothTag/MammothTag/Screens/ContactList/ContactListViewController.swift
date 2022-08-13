//
//  ContactListViewController.swift
//  MammothTag
//
//  Created by Anwar Hajji on 11/08/2022.
//

import UIKit

class ContactListViewController: UIViewController, Storyboarded {

    
    
    @IBOutlet weak var contactListLbl: UILabel!
    @IBOutlet weak var searchIcon: UIImageView!
    @IBOutlet weak var addIcon: UIImageView!
    @IBOutlet weak var contactsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupTableView()
        setupLocalizedText()
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
    
    

}


extension ContactListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 110.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    
}

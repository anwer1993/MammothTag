//
//  ContactListViewController.swift
//  MammothTag
//
//  Created by Anwar Hajji on 11/08/2022.
//
import CoreNFC
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
    
    var from: Int = 0
    
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
    var session: NFCNDEFReaderSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupTableView()
        setupLocalizedText()
        swipeTap = UIPanGestureRecognizer(target: self, action:  #selector(didSwipeAlert(_:)))
        segmentView.isUserInteractionEnabled = true
        swipeTap.delegate = self
        segmentView.addGestureRecognizer(swipeTap)
        segmentView.isHidden = true
        let addUserTap = UITapGestureRecognizer(target: self, action: #selector(addUser(_:)))
        addIcon.addTagGesture(addUserTap)
    }
    
    @objc func addUser(_ gesture: UITapGestureRecognizer? = nil) {
        from  = 0
        guard NFCNDEFReaderSession.readingAvailable else {
            let alertController = UIAlertController(
                title: "SCANING_NOT_SUPPORTED".localized,
                message: "DEVICE_NOT_SUPPORT_SCAN".localized,
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        session?.alertMessage = "SCAN_NFC_DESC".localized
        session?.begin()
    }
    
    @objc func didSwipeAlert(_ sender:UIPanGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
            let location = swipeTap.location(in: segmentView)
            if AppSettings().appLanguage == .EN {
                if location.x > segmentView.frame.width * 0.5 {
                    if selectedItem != 1 {
                        selectedItem = 1
                    }
                } else {
                    if selectedItem != 0 {
                        selectedItem = 0
                    }
                }
            } else {
                if location.x < segmentView.frame.width * 0.5 {
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initView()
        emptyView.isHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getContactList()
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
        contactLabl.text = "CONTACTS".localized
        requestLabel.text = "REQUESTS".localized
        emptyLabel.text = "EMPTY_LIST".localized
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
            Router.shared.push(with: self.navigationController, screen: .ContactDetails(user_id: id, nfcTag: "", sourceController: 0), animated: true)
        }
        
    }
    
    
}


extension ContactListViewController: NFCNDEFReaderSessionDelegate {
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        
    }
    
    
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        print("session did begin")
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        if tags.count > 1 {
            // Restart polling in 500ms
            let retryInterval = DispatchTimeInterval.milliseconds(500)
            session.alertMessage = "More than 1 tag is detected, please remove all tags and try again."
            DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval, execute: {
                session.restartPolling()
            })
            return
        }
        
        // Connect to the found tag and perform NDEF message reading
        let tag = tags.first!
        session.connect(to: tag, completionHandler: { (error: Error?) in
            if nil != error {
                session.alertMessage = "Unable to connect to tag."
                session.invalidate()
                return
            }
            
            tag.queryNDEFStatus(completionHandler: { (ndefStatus: NFCNDEFStatus, capacity: Int, error: Error?) in
                if .notSupported == ndefStatus {
                    session.alertMessage = "Tag is not NDEF compliant"
                    session.invalidate()
                    return
                } else if nil != error {
                    session.alertMessage = "Unable to query NDEF status of tag"
                    session.invalidate()
                    return
                }
                
                tag.readNDEF(completionHandler: { (message: NFCNDEFMessage?, error: Error?) in
                    var statusMessage: String
                    if nil != error || nil == message {
                        statusMessage = "Fail to read NDEF from tag"
                    } else {
                        guard let payload = message!.records.first else {return}
                        switch payload.typeNameFormat {
                        case .nfcWellKnown:
                            if let user_id = payload.wellKnownTypeURIPayload()?.absoluteString {
                                DispatchQueue.main.async {
                                    self.getUserByNFCTag(nfc_tag: user_id)
                                }
                            }
                        case .absoluteURI:
                            break
                        case .media:
                            break
                        case .nfcExternal, .empty, .unknown, .unchanged:
                            fallthrough
                        @unknown default:
                            break
                        }
                    }
                    session.invalidate()
                })
            })
        })
    }
    
    
}



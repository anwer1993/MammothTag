//
//  SettingsViewController.swift
//  MammothTag
//
//  Created by Anwar Hajji on 11/08/2022.
//

import UIKit
import Alamofire
import Kingfisher

class SettingsViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var profileImageShadowView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var topViewBackgroundImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var viewProfileImage: UIView!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var profileNameLbl: UILabel!
    @IBOutlet weak var settingsTableView: UITableView!
    @IBOutlet weak var infoViewWidthConstarinte: NSLayoutConstraint!
    
    @IBOutlet weak var shadowInffoViewWidthConstarinte: NSLayoutConstraint!
    
    
    
    
    var viewModel = SettingsViewModel()
    var profile: ProfileModel?
    
    var settingsArray = ["My information", "Change passoword", "Abous Us", "Terms & conditions", "Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupTableView()
        setupUI()
        viewModel.bindViewModelDataToController = {[weak self] success,model, message in
            guard let this = self else {
                return
            }
            this.showOrHideLoader(done: true)
            this.updateUIWhenGetProfile(sucess: success ,profile: model, message: message)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showOrHideLoader(done: false)
        viewModel.getProfile()
    }
    
    func setupTableView() {
        let cell = UINib(nibName: "SeettingsTableViewCell", bundle: nil)
        settingsTableView.register(cell, forCellReuseIdentifier: "SeettingsTableViewCell")
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.tableFooterView = UIView()
    }
    
    func setupUI() {
        setupTopViewConstarinte()
        shadowView.applySketchShadow(color: .black37, alpha: 1, x: 0, y: 2, blur: 20, spread: 0)
        shadowView.layer.cornerRadius = 60
        TopView.applyRadiusMaskFor(topLeft: 30.0, bottomLeft: 30.0, bottomRight: 30.0, topRight: 70.0)
        profileImageShadowView.layer.cornerRadius = 55
        profileImageShadowView.applySketchShadow(color: .black37, alpha: 1, x: 0, y: 2, blur: 20, spread: 0)
        viewProfileImage.layer.cornerRadius = 55
        profileImage.layer.cornerRadius = 55
        profileNameLbl.font = UIFont(name: "Lato-Black", size: 18)
        profileNameLbl.textColor = .tangerine
        emailLbl.font = UIFont(name: "Lato-Regular", size: 14)
        emailLbl.textColor = .white
        ageLbl.font = UIFont(name: "Lato-Regular", size: 14)
        ageLbl.textColor = .white
    }
    
    func setupTopViewConstarinte() {
        let screenWidth = UIScreen.main.bounds.width
        shadowInffoViewWidthConstarinte.constant = screenWidth > 390 ? 374 : 339
        infoViewWidthConstarinte.constant = screenWidth > 390 ? 375 : 340
        view.layoutIfNeeded()
    }
    
    func updateUIWhenGetProfile(sucess: String?, profile: ProfileModel?, message: String) {
        if sucess == "success" {
            if let profile = profile {
                self.profile = profile
                emailLbl.text = profile.email
                profileNameLbl.text = "\(profile.name ?? "") \(profile.username ?? "")"
                if let dob = profile.birthday?.dateFromString, let age = dob.age {
                    ageLbl.text = "\(age)"
                }
                if let picture = profile.picture, picture.isEmptyString == false {
                    let url = URL(string: picture)
                    profileImage.kf.setImage(with: url)
                } else {
                    profileImage.image = UIImage(named: "avatar")
                }
            } else {
                showAlert(withTitle: "Error", withMessage: message)
            }
        } else {
            showAlertWithOk(withTitle: "Error", withMessage: "Session expired") {
                self.expireSession(isExppired: true)
            }
        }
        
    }
    
}


extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SeettingsTableViewCell", for: indexPath) as? SeettingsTableViewCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        cell.descriptionLabel.text = settingsArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            if let profile = profile {
                Router.shared.push(with: self.navigationController, screen: .UpdateProfile(profile: profile), animated: true)
            }
        } else if indexPath.row == 1 {
            Router.shared.present(screen: .UpdatePassword, modalePresentatioinStyle: .fullScreen, completion: nil)
        } else if indexPath.row == 2 {
            Router.shared.push(with: self.navigationController, screen: .Terms(source: .FromSettings), animated: true)
        } else if indexPath.row == 3 {
            Router.shared.push(with: self.navigationController, screen: .Terms(source: .none), animated: true)
        } else if indexPath.row == 4 {
            logout()
        }
    }
    
}

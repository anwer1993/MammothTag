//
//  HomeCollectionViewVC.swift
//  MammothTag
//
//  Created by Anwar Hajji on 30/08/2022.
//

import Foundation
import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listCardNetwork.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SocialMediaTableViewCell", for: indexPath) as?  SocialMediaTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.warmGrey.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.applySketchShadow(color: UIColor.black13, alpha: 0.8, x: 0, y: 2, blur: 20, spread: 0)
        cell.socialMediaLink.text = listCardNetwork[indexPath.section].link
        cell.configCell(network: listCardNetwork[indexPath.section], selectedItem: selectedItem)
        cell.tag = indexPath.section
        let tap = UITapGestureRecognizer(target: self, action: #selector(diddSelectItem(_:)))
        cell.addTagGesture(tap)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        listCardNetwork.swapAt(sourceIndexPath.section, destinationIndexPath.section)
        let moved = listCardNetwork[destinationIndexPath.section]
        if selectedItem == 1 && destinationIndexPath.section == 0 {
            openFirstCard(card_id: "\(moved.cardID ?? "")", card_network_id: "\(moved.id ?? 0)")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    @objc func diddSelectItem(_ gesture: UITapGestureRecognizer? = nil) {
        guard let tag = gesture?.view?.tag else {return}
        editNetworkVc.network = listCardNetwork[tag]
        editNetworkVc.handleTapWhenDelete = { network in
            self.editNetworkVc.removeView()
            self.deleteNetwork(network: network)
        }
        editNetworkVc.handleTapWhenSave = { network in
            self.editNetworkVc.removeView()
            self.editNetwork(network: network)
        }
        editNetworkVc.handleTapWhenOpen =  { network in
            // open network
            self.editNetworkVc.removeView()
            print(network.link ?? "")
            if network.socialNetworkID == "1" {
                Contstant.openFb(username: network.link ?? "") {
                    self.showAlert(withTitle: "Oops", withMessage: "The link does not found")
                }
            } else if network.socialNetworkID == "2" {
                Contstant.openInstagram(link: network.link ?? "") {
                    self.showAlert(withTitle: "Oops", withMessage: "The link does not found")
                }
            } else if network.socialNetworkID == "3" {
                Contstant.openLinkedIn(link: network.link ?? "") {
                    self.showAlert(withTitle: "Oops", withMessage: "The link does not found")
                }
            } else if network.socialNetworkID == "4" {
                Contstant.openPaypal(link: network.link ?? "") {
                    self.showAlert(withTitle: "Oops", withMessage: "The link does not found")
                }
            } else if network.socialNetworkID == "5" {
                Contstant.openSkype(link: network.link ?? "") {
                    self.showAlert(withTitle: "Oops", withMessage: "The link does not found")
                } installSkypeCompletion: {
                    let alert = UIAlertController(title: "Skype app not found", message: "Would you like to unstall it ?", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                    let confirmAction = UIAlertAction(title: "Proceed", style: .destructive) { _ in
                        if let webURL = URL(string: "http://itunes.com/apps/skype/skype") {
                            UIApplication.shared.open(webURL)
                        }
                    }
                    alert.addAction(cancelAction)
                    alert.addAction(confirmAction)
                    self.present(alert, animated: true)
                }

            } else if network.socialNetworkID == "6" {
                Contstant.openSnapshat(link: network.link ?? "") {
                    self.showAlert(withTitle: "Oops", withMessage: "The link does not found")
                }
            } else if network.socialNetworkID == "7" {
                Contstant.openTiktok(link: network.link ?? "") {
                    self.showAlert(withTitle: "Oops", withMessage: "The link does not found")
                }
            } else if network.socialNetworkID == "8" {
                Contstant.openTwitch(link: network.link ?? "") {
                    self.showAlert(withTitle: "Oops", withMessage: "The link does not found")
                }
            } else if network.socialNetworkID == "9" {
                Contstant.openTwitter(link: network.link ?? "") {
                    self.showAlert(withTitle: "Oops", withMessage: "The link does not found")
                }
            } else if network.socialNetworkID == "10" {
                Contstant.openEmail(link: network.link ?? "") {
                    self.showAlert(withTitle: "Oops", withMessage: "The link does not found")
                }
            } else if network.socialNetworkID == "11" {
                Contstant.openWebsite(link: network.link ?? "") {
                    self.showAlert(withTitle: "Oops", withMessage: "The website url does not found")
                }
            } else if network.socialNetworkID == "12" {
                Contstant.openTelegram(link: network.link ?? "") {
                    self.showAlert(withTitle: "Oops", withMessage: "The link does not found")
                }
            } else if network.socialNetworkID == "13" {
                Contstant.openFaceTime(link: network.link ?? "") {
                    self.showAlert(withTitle: "Oops", withMessage: "FaceTime does not available")
                }
            } else if network.socialNetworkID == "14" {
                Contstant.openYoutube(link: network.link ?? "") {
                    self.showAlert(withTitle: "Oops", withMessage: "The link does not found")
                }
            } else if network.socialNetworkID == "15" {
                Contstant.openPhone(link: network.link ?? "") {
                }
            }
        }
        self.tabBarController?.tabBar.isHidden = true
        self.viewContainer.addBlurEffect()
        addChildVc(editNetworkVc) {
            [weak self] in
            guard let this = self else {return}
            this.updateUIWhenRemovePopup()
        }
    }
    
}

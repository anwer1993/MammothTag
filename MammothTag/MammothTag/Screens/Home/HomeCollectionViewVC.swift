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
                        let urlString = "https://www.instagram.com/hajji.anouer"
                        let appurl = "fb://profile/aroun.aroun.980"
            let tiktok = "https://www.tiktok.com/@anwer"
            //            let url = "instagram://user?username=johndoe"
                        let appURL = URL(string: tiktok)!
                        let application = UIApplication.shared
            
                        if application.canOpenURL(appURL) {
                            application.open(appURL)
                        } else {
                            // if Instagram app is not installed, open URL inside Safari
                            let webURL = URL(string: tiktok)!
                            application.open(webURL)
                        }
//            let application = UIApplication.shared
//            let email = "hajjianwer2013@gmail.com"
//            if let url = URL(string: "mailto:\(email)") {
//              if #available(iOS 10.0, *) {
//                UIApplication.shared.open(url)
//              } else {
//                UIApplication.shared.openURL(url)
//              }
//            }
            
            print(network.link ?? "")
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

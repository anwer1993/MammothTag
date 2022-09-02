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
//        cell.clipsToBounds = true
        cell.socialMediaLink.text = listCardNetwork[indexPath.section].link
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        listCardNetwork.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        print(listCardNetwork.first?.link)
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
    
}

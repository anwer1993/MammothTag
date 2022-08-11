//
//  HomeViewController.swift
//  MammothTag
//
//  Created by Anwar Hajji on 11/08/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet var viewContainer: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var moreView: UIView!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var activateNFCImage: UIImageView!
    @IBOutlet weak var activateNFCLabel: UILabel!
    @IBOutlet weak var digitalCardLabel: UILabel!
    @IBOutlet weak var priviligeDropDownIcon: UIImageView!
    @IBOutlet weak var privilageLabl: UILabel!
    @IBOutlet weak var privilageView: UIView!
    @IBOutlet weak var stackViewOfSelectedScreen: UIStackView!
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var customSegmentControlView: CustomSegmentControlView!
    @IBOutlet weak var socialMediaLabel: UILabel!
    @IBOutlet weak var addSocialeMediaImage: UIImageView!
    @IBOutlet weak var addSocialeMediaLabel: UILabel!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var topBgImage: UIImageView!
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let frame = CGRect(x: 0, y: 0, width: customSegmentControlView.bounds.width, height: customSegmentControlView.bounds.height)
        let view = CustomSegmentControlView(frame: frame)
        self.customSegmentControlView.addSubview(view)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    func initView() {
        
//        customTabbarView.backgroundColor = .redBrown
        customSegmentControlView.layer.cornerRadius = 25.0
        customSegmentControlView.applySketchShadow(color: .black9, alpha: 0.9, x: 0, y: 2, blur: 20, spread: 0)
        moreView.layer.cornerRadius = moreView.bounds.width * 0.5
        privilageView.layer.cornerRadius = 15.0
        privilageView.layer.borderColor = UIColor.white.cgColor
        privilageView.layer.borderWidth = 1
        homeView.layer.cornerRadius = homeView.bounds.width * 0.5
        accountView.layer.cornerRadius = accountView.bounds.width * 0.5
        contactView.layer.cornerRadius = contactView.bounds.width * 0.5
        addView.layer.cornerRadius = 25.0
        addView.layer.backgroundColor = UIColor.redBrown.cgColor
        socialMediaLabel.textColor = .tangerine
        addSocialeMediaLabel.textColor = .brownishGrey
        activateNFCLabel.textColor = .white80
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

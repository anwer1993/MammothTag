//
//  CustomSegmentControlView.swift
//  MammothTag
//
//  Created by Anwar Hajji on 11/08/2022.
//

import Foundation
import UIKit

//@IBDesignable
class CustomSegmentControlView : UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var publicProfileLbl: UILabel!
    @IBOutlet weak var publicProfileView: UIView!
    @IBOutlet weak var limitedAccessLbl: UILabel!
    @IBOutlet weak var limitedAccessView: UIView!
    
    var selectedItem: Int = 0 {
        didSet {
            updateMenu()
        }
    }
    
    var recognizer: UITapGestureRecognizer {
        get {
            return UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("CustomSegmentControlView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        contentView.center = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.5)
        contentView.layer.backgroundColor = UIColor.clear.cgColor
        contentView.layer.cornerRadius = 25
        roundedView.layer.cornerRadius = 25
        styleViews()
        selectedItem = 0
        publicProfileView.tag = 0
        limitedAccessView.tag = 1
        publicProfileView.addTagGesture(recognizer)
        limitedAccessView.addTagGesture(recognizer)
    }
    
    private func styleViews() {
        styleView(publicProfileView)
        styleView(limitedAccessView)
    }
    
    private func styleView(_ view: UIView) {
        view.layer.cornerRadius = 25.0
        view.layer.backgroundColor = UIColor.tangerine.cgColor
    }
    
    private func updateMenu() {
        if selectedItem == 0 {
            activateItem(view: publicProfileView, label: publicProfileLbl)
            deactivateItem(view: limitedAccessView, label: limitedAccessLbl)
        } else {
            activateItem(view: limitedAccessView, label: limitedAccessLbl)
            deactivateItem(view: publicProfileView, label: publicProfileLbl)
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
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        guard let tag  = sender?.view?.tag else {return}
        selectedItem = tag
    }
    
}

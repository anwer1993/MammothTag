//
//  CustomSegmentControlView.swift
//  MammothTag
//
//  Created by Anwar Hajji on 11/08/2022.
//

import Foundation
import UIKit

//@IBDesignable
class CustomSegmentControlView : UIView, UIGestureRecognizerDelegate {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var roundedView: UIStackView!
    @IBOutlet weak var publicProfileLbl: UILabel!
    @IBOutlet weak var publicProfileView: UIView!
    @IBOutlet weak var limitedAccessLbl: UILabel!
    @IBOutlet weak var limitedAccessView: UIView!
    
    var selectedItem: Int = 0 {
        didSet {
            updateMenu()
        }
    }
    
    var handleTapWhenChanged: (Int) -> () = {_ in}
    
    var recognizer: UITapGestureRecognizer {
        get {
            return UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        }
    }
    
    var swipeTap = UIPanGestureRecognizer()
    
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
        swipeTap = UIPanGestureRecognizer(target: self, action:  #selector(didSwipeAlert(_:)))
        roundedView.isUserInteractionEnabled = true
        swipeTap.delegate = self
        roundedView.addGestureRecognizer(swipeTap)
    }
    
    private func styleViews() {
//        styleView(publicProfileView)
//        styleView(limitedAccessView)
    }
    
    private func styleView(_ view: UIView) {
        view.layer.cornerRadius = 25.0
        view.layer.backgroundColor = UIColor.tangerine.cgColor
    }
    
    private func updateMenu() {
        if selectedItem == 0 {
            activateItem(view: publicProfileView, label: publicProfileLbl)
            deactivateItem(view: limitedAccessView, label: limitedAccessLbl)
            limitedAccessView.layer.shadowOpacity  = 0
            publicProfileView.applySketchShadow(color: .black37, alpha: 1, x: 0, y: 1, blur: 20, spread: 0)
        } else {
            activateItem(view: limitedAccessView, label: limitedAccessLbl)
            deactivateItem(view: publicProfileView, label: publicProfileLbl)
            publicProfileView.layer.shadowOpacity  = 0
            limitedAccessView.applySketchShadow(color: .black37, alpha: 1, x: 0, y: 1, blur: 20, spread: 0)
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
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        guard let tag  = sender?.view?.tag else {return}
        selectedItem = tag
        handleTapWhenChanged(tag)
    }
    
    @objc func didSwipeAlert(_ sender:UIPanGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
            let location = swipeTap.location(in: roundedView)
            print("location", location.x)
            if location.x > roundedView.frame.width * 0.5 {
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

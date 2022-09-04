//
//  AddNewCardVc.swift
//  MammothTag
//
//  Created by Anwar Hajji on 15/08/2022.
//

import Foundation
import UIKit


class AddNewCardVc: UIViewController, SubViewConroller {
    
    
    @IBOutlet weak var saveBtn: GradientButton!
    @IBOutlet weak var famillyCardInsideView: UIView!
    @IBOutlet weak var famillyCardCheckView: UIView!
    @IBOutlet weak var famillyCardLbl: UILabel!
    @IBOutlet weak var famillystack: UIStackView!
    @IBOutlet weak var forJobsInsideView: UIView!
    @IBOutlet weak var forJobscheckView: UIView!
    @IBOutlet weak var forJobsLbl: UILabel!
    @IBOutlet weak var jobsStack: UIStackView!
    @IBOutlet weak var digitalBusinessCardInsideView: UIView!
    @IBOutlet weak var digitalBusinessCardCheeckView: UIView!
    @IBOutlet weak var digitalBusinessCardLbl: UILabel!
    @IBOutlet weak var digitalBusinessCardStack: UIStackView!
    @IBOutlet weak var digitalCardInsideView: UIView!
    @IBOutlet weak var digitalCardCheckView: UIView!
    @IBOutlet weak var digitalCardLbl: UILabel!
    @IBOutlet weak var digitalCardStack: UIStackView!
    @IBOutlet weak var meenuStack: UIStackView!
    @IBOutlet weak var cardNameTextField: UITextField!
    @IBOutlet weak var addNewCardLbl: UILabel!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var viewControl: UIControl!
    @IBOutlet var viewContainer: UIView!
    
    var handleTapWhenDismiss: () -> Void = {}
    var handleTapWhenSave: (String, String) -> Void = {_,_ in}
    
    var tapGesture: UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    }
    
    var selectedMode: Int = 0 {
        didSet {
            updateUIWhenSelectMode()
            
        }
    }
    
    var cardName = ""
    
    var isUpdateAction: Bool = false
    
    var card: DatumCard?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let card = card {
            addNewCardLbl.text = "Update card"
            selectedMode = Int(card.type ?? "1") ?? 1
            cardNameTextField.text = card.name ?? ""
        } else {
            addNewCardLbl.text = "Add new card"
            cardNameTextField.text = ""
            selectedMode = 1
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func initView() {
        viewControl.addTarget(self, action: #selector(removeView(_:)), for: .touchUpInside)
        viewControl.alpha = 0.5
        closeButton.layer.cornerRadius = closeButton.frame.width * 0.5
        menuView.layer.cornerRadius = 30.0
        menuView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let bottomLine = CALayer()
        let width = UIScreen.main.bounds.width - 48
        bottomLine.frame = CGRect(x: 0.0, y: 54, width: width, height: 1.0)
        bottomLine.backgroundColor = UIColor.pinkishGrey.cgColor
        cardNameTextField.borderStyle = UITextField.BorderStyle.none
        cardNameTextField.layer.addSublayer(bottomLine)
        customizeView(digitalCardCheckView, insideView: digitalCardInsideView)
        customizeView(digitalBusinessCardCheeckView, insideView: digitalBusinessCardInsideView)
        customizeView(forJobscheckView, insideView: forJobsInsideView)
        customizeView(famillyCardCheckView, insideView: famillyCardInsideView)
        digitalCardStack.tag = 1
        digitalCardStack.addTagGesture(tapGesture)
        digitalBusinessCardStack.tag = 2
        digitalBusinessCardStack.addTagGesture(tapGesture)
        jobsStack.tag = 3
        jobsStack.addTagGesture(tapGesture)
        famillystack.tag = 4
        famillystack.addTagGesture(tapGesture)
        
        saveBtn.gradientbutton()
        saveBtn.applySketchShadow(color: .tangerine30, alpha: 1, x: 0, y: 10, blur: 30, spread: 0)
        cardNameTextField.delegate = self
        digitalCardLbl.font = UIFont(name: "Lato-SemiBold", size: 16)
        digitalBusinessCardLbl.font = UIFont(name: "Lato-SemiBold", size: 16)
        forJobsLbl.font = UIFont(name: "Lato-SemiBold", size: 16)
        famillyCardLbl.font = UIFont(name: "Lato-SemiBold", size: 16)
        addNewCardLbl.font = UIFont(name: "Lato-Bold", size: 18)
        addNewCardLbl.textColor = .redBrown
        cardNameTextField.font = UIFont(name: "Lato-Regular", size: 16)
        saveBtn.titleLabel?.font = UIFont(name: "Lato-SemiBold", size: 16)
    }
    
    func customizeView(_ view: UIView, insideView: UIView) {
        view.layer.cornerRadius = view.frame.width * 0.5
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.redBrown.cgColor
        insideView.layer.cornerRadius = insideView.frame.width * 0.5
        insideView.layer.backgroundColor = UIColor.redBrown.cgColor
    }
    
    func deselectView(_ view: UIView, insideView: UIView) {
        view.layer.borderColor = UIColor.warmGreyTwo.cgColor
        insideView.isHidden = true
    }
    
    func selectView(_ view: UIView, insideView: UIView) {
        view.layer.borderColor = UIColor.redBrown.cgColor
        insideView.isHidden = false
    }
    
    func updateUIWhenSelectMode() {
        switch selectedMode {
        case 1:
            selectView(digitalCardCheckView, insideView: digitalCardInsideView)
            deselectView(digitalBusinessCardCheeckView, insideView: digitalBusinessCardInsideView)
            deselectView(forJobscheckView, insideView: forJobsInsideView)
            deselectView(famillyCardCheckView, insideView: famillyCardInsideView)
            break
        case 2:
            deselectView(digitalCardCheckView, insideView: digitalCardInsideView)
            selectView(digitalBusinessCardCheeckView, insideView: digitalBusinessCardInsideView)
            deselectView(forJobscheckView, insideView: forJobsInsideView)
            deselectView(famillyCardCheckView, insideView: famillyCardInsideView)
            break
        case 3:
            deselectView(digitalCardCheckView, insideView: digitalCardInsideView)
            deselectView(digitalBusinessCardCheeckView, insideView: digitalBusinessCardInsideView)
            selectView(forJobscheckView, insideView: forJobsInsideView)
            deselectView(famillyCardCheckView, insideView: famillyCardInsideView)
            break
        case 4 :
            deselectView(digitalCardCheckView, insideView: digitalCardInsideView)
            deselectView(digitalBusinessCardCheeckView, insideView: digitalBusinessCardInsideView)
            deselectView(forJobscheckView, insideView: forJobsInsideView)
            selectView(famillyCardCheckView, insideView: famillyCardInsideView)
            break
        default:
            break
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if let tag = sender?.view?.tag {
            selectedMode = tag
        }
    }
    
    @objc func removeView(_ gesture: UIGestureRecognizer) {
        removeView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.menuView.endEditing(true)
    }
    
    func removeView() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
        cardNameTextField.text = ""
        selectedMode = 1
        handleTapWhenDismiss()
    }
    
    @IBAction func closeButtonDidTapped(_ sender: Any) {
        removeView()
    }
    
    @IBAction func saveBtnDidTapped(_ sender: Any) {
        handleTapWhenSave(cardName, "\(selectedMode)")
    }
    
}


extension AddNewCardVc: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        cardName = textField.text ?? ""
        return true;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        cardName = textField.text ?? ""
        print("TextField did begin editing method called")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        cardName = textField.text ?? ""
        print("TextField did end editing method called")
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        cardName = textField.text ?? ""
        print("TextField did change", cardName)
    }
    
}

//
//  RegisterViewControllerImagePicker.swift
//  MammothTag
//
//  Created by Anwar Hajji on 10/08/2022.
//

import Foundation
import UIKit
import AVFoundation
import Photos

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            profileImage.image = image
            profileImage.contentMode = .scaleAspectFill
        }else{
            print("Something went wrong")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        /*
         Get the image from the info dictionary.
         If no need to edit the photo, use `UIImagePickerControllerOriginalImage`
         instead of `UIImagePickerControllerEditedImage`
         */
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            self.profileImage.image = editedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
}

extension RegisterViewController {
    
    @objc func showActionSheet(_ sender: UITapGestureRecognizer? = nil) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.requestCameraAccess()
        }))
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.requestGalerieAccess()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
    
    func camera() {
        DispatchQueue.main.async {[weak self] in
            guard let this = self else {return}
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let myPickerController = UIImagePickerController()
                myPickerController.delegate = this
                myPickerController.sourceType = .camera
                this.present(myPickerController, animated: true, completion: nil)
            }
        }
    }
    
    func photoLibrary() {
        DispatchQueue.main.async {[weak self] in
            guard let this = self else {return}
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let myPickerController = UIImagePickerController()
                myPickerController.delegate = this
                myPickerController.sourceType = .photoLibrary
                this.present(myPickerController, animated: true, completion: nil)
            }
        }
    }
    
    func showSettingAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController (title: title, message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "CANCEL".localized, style: .destructive, handler: nil)
            let settingsAction = UIAlertAction(title: "SETTINGS".localized, style: .default) { action in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)")
                    })
                }
            }
            alertController.addAction(cancelAction)
            alertController.addAction(settingsAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func requestCameraAccess() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status{
        case .authorized:
            self.camera()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.camera()
                }
            }
        case .denied, .restricted:
            showSettingAlert(title: "ACCESS_DENIED".localized, message: "CAM_PRMISSION_DENIED".localized)
            break
        default:
            break
        }
    }
    
    func requestGalerieAccess() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status{
        case .authorized:
            self.photoLibrary()
        case .denied, .restricted:
            showSettingAlert(title: "ACCESS_DENIED".localized, message: "PHOTOS_PRMISSION_DENIED".localized)
            break
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == PHAuthorizationStatus.authorized{
                    self.photoLibrary()
                }
            })
        default:
            break
        }
    }
    
}

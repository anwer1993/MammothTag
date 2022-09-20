//
//  HomeWriteNFCTAg.swift
//  MammothTag
//
//  Created by Anwar Hajji on 16/09/2022.
//

import Foundation
import CoreNFC
import UIKit
import Branch


extension HomeViewController: NFCNDEFReaderSessionDelegate{
    
    // MARK: - NFCNDEFReaderSessionDelegate
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
    }
    
    /// - Tag: writeToTag
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        if tags.count > 1 {
            // Restart polling in 500 milliseconds.
            let retryInterval = DispatchTimeInterval.milliseconds(500)
            session.alertMessage = "More than 1 tag is detected. Please remove all tags and try again."
            DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval, execute: {
                session.restartPolling()
            })
            return
        }
        
        // Connect to the found tag and write an NDEF message to it.
        guard let tag = tags.first else {
            session.alertMessage = "Unable to connect to tag."
            session.invalidate()
            return
        }
        session.connect(to: tag, completionHandler: { (error: Error?) in
            if nil != error {
                session.alertMessage = "Unable to connect to tag."
                session.invalidate()
                return
            }
            
            tag.queryNDEFStatus(completionHandler: { (ndefStatus: NFCNDEFStatus, capacity: Int, error: Error?) in
                guard error == nil else {
                    session.alertMessage = "Unable to query the NDEF status of tag."
                    session.invalidate()
                    return
                }
                
                switch ndefStatus {
                case .notSupported:
                    session.alertMessage = "Tag is not NDEF compliant."
                    session.invalidate()
                case .readOnly:
                    session.alertMessage = "Tag is read only."
                    session.invalidate()
                case .readWrite:
                    let branchUniversalObject: BranchUniversalObject = BranchUniversalObject(canonicalIdentifier: "content/12345")
                    branchUniversalObject.title = "anwer"
                    branchUniversalObject.imageUrl = "sellerImage"
                    branchUniversalObject.contentMetadata.customMetadata = ["id": "\(self.profile?.id ?? 0)"]
                    let lp = BranchLinkProperties()
                    lp.channel = "Mammoth"
                    lp.feature = "sharing"
                    lp.campaign = "content 123 launch"
                    lp.stage  = "newUser"
                    lp.controlParams = ["id": "\(self.profile?.id ?? 0)"]
                    lp.controlParams["$web_only"] = false
                    branchUniversalObject.getShortUrl(with: lp) { url, error in
                        if error == nil {
                            print("url", url)
                            let uriPayloadFromURL = NFCNDEFPayload.wellKnownTypeURIPayload(
                                url: URL(string: (url ?? ""))!
                            )!
                            let messge = NFCNDEFMessage(records: [(uriPayloadFromURL)])
                            tag.writeNDEF(messge, completionHandler: { (error: Error?) in
                                if nil != error {
                                    session.alertMessage = "Write NDEF message fail: \(error!)"
                                } else {
                                    DispatchQueue.main.async {
                                        if self.isActivateBtnTapped  {
                                            let nfc_id = UUID().uuidString
                                            self.activateNFCTag(nfc_tag: nfc_id, branch_link: url ??  "")
                                        } else {
                                            session.alertMessage = "NFC TAG Activated"
                                        }
                                        session.invalidate()
                                    }
                                    session.alertMessage = "NFC TAG Activated"
                                }
                                session.invalidate()
                            })
                        }
                    }
                @unknown default:
                    session.alertMessage = "Unknown NDEF tag status."
                    session.invalidate()
                }
            })
        })
    }
    
    /// - Tag: sessionBecomeActive
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        
    }
    
    /// - Tag: endScanning
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        // Check the invalidation reason from the returned error.
        if let readerError = error as? NFCReaderError {
            // Show an alert when the invalidation reason is not because of a success read
            // during a single tag read mode, or user canceled a multi-tag read mode session
            // from the UI or programmatically using the invalidate method call.
            if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
                && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
                let alertController = UIAlertController(
                    title: "Session Invalidated",
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}

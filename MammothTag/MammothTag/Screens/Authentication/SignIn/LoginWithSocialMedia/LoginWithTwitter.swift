//
//  LoginWithTwitter.swift
//  MammothTag
//
//  Created by Anwar Hajji on 15/10/2022.
//

import Foundation
import TwitterKit
import FirebaseAuth
import FirebaseCore

extension SignInController {
    
    func logoutFromFirebase() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
    
    @objc
    func loginWithTwitter() {
        logoutFromFirebase()
        TWTRTwitter.sharedInstance().logIn { [weak self](session, error) in
            if let session = session {
                self?.twitter_session = session
                self?.loginToTwitterWithFirebase()
            }else {
                print("error: \(String(describing: error?.localizedDescription))");
            }
        }
    }
    
    func loginToTwitterWithFirebase() {
        guard let twitter_session = twitter_session else {return}
        let credentials = TwitterAuthProvider.credential(withToken: twitter_session.authToken, secret: twitter_session.authTokenSecret)
        Auth.auth().signIn(with: credentials) {[weak self] result, error in
            if let  error = error {
                print(error.localizedDescription)
            }
            guard let user = result?.user else {return}
            self?.fetchEmail(completion: { email in
                if let email = email {
                    let full_name = user.displayName ?? ""
                    let email = email
                    let profile_picture_url = user.photoURL?.absoluteString ?? ""
                    let loginModel = LoginWithSocialMediaModel(name: full_name, lastName: "", email: email, url_Picture : profile_picture_url)
                    self?.register(With: .loginWithTwitter(userModel: loginModel))
                }
            })
        }
    }
    
    func fetchEmail(completion:@escaping (String?) -> ()) {
        guard let twitter_session = twitter_session else {return}
        let client_id = twitter_session.userID
        let client = TWTRAPIClient(userID: client_id)
        client.requestEmail { email, error in
            if let  error = error {
                print(error.localizedDescription)
            }
            completion(email)
        }
    }
}

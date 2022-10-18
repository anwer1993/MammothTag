//
//  LoginWithTwitter.swift
//  MammothTag
//
//  Created by Anwar Hajji on 15/10/2022.
//

import Foundation
import FirebaseAuth
import FirebaseCore

extension SignInController: AuthUIDelegate {
    
    @objc
    func loginWithTwitter() {
        provider.getCredentialWith(nil) { credential, error in
            if let error = error {
                print(error.localizedDescription)
            } else if credential != nil {
                self.showOrHideLoader(done: false)
                Auth.auth().signIn(with: credential!) { authResult, error in
                    if let error  = error {
                        print(error.localizedDescription)
                    }
                    guard let user = authResult?.user else {return}
                    guard let additional_info = authResult?.additionalUserInfo?.profile else {return}
                    let first_name = (user.displayName ?? "").subString().0
                    let last_name = (user.displayName ?? "").subString().1
                    let email = (additional_info["email"] as? String) ?? ""
                    let profile_picture_url = user.photoURL?.absoluteString ?? ""
                    let loginModel = LoginWithSocialMediaModel(name: first_name, lastName: last_name, email: email, url_Picture : profile_picture_url)
                    self.register(With: .loginWithTwitter(userModel: loginModel), isFromTwitterLogin: true)
                }
            }
        }
    }
    
}

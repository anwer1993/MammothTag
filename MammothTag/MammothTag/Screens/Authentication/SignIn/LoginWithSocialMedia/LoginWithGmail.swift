//
//  SignInWithViewController.swift
//  MammothTag
//
//  Created by Anwar Hajji on 13/10/2022.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import FirebaseCore

extension SignInController {
    
    func register(With loginType: LoginType) {
        showOrHideLoader(done: false)
        AuthenticationService.sharedInstance.register(with: loginType) { [weak self] resp in
            guard let this = self else {return}
            this.showOrHideLoader(done: true)
            if let token = resp.token, let success = resp.result, success == true {
                AccountManager.shared.token = token
                switch loginType {
                case .simpleLogin(_):
                    AccountManager.shared.loginType = .simpleLogin
                case .loginWithGmail(_):
                    AccountManager.shared.loginType = .loginWithGmail
                case .loginWithFacebook(_):
                    AccountManager.shared.loginType = .loginWithFacebook
                case .loginWithApple(_):
                    AccountManager.shared.loginType = .loginWithApple
                case .loginWithTwitter(_):
                    AccountManager.shared.loginType = .loginWithTwitter
                }
                if this.sourceController == 0 {
                    Contstant.updateRootVC()
                } else {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let rootViewController = storyboard.instantiateViewController(withIdentifier: "ContactDetailsViewController") as? ContactDetailsViewController {
                        rootViewController.user_id = this.user_id
                        rootViewController.sourceController = 1
                        UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.rootViewController = rootViewController
                        UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.makeKeyAndVisible()
                    }
                }
            }
        }
    }
    
    func signupWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID  else { return }
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
            if error  != nil {
                return
            }
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { authResult, error in
                if let data = authResult {
                    print("login with google succeded")
                    let loginModel = LoginWithSocialMediaModel(name: user?.profile?.givenName ?? "", lastName: user?.profile?.familyName ?? "", email: user?.profile?.email ?? "", url_Picture : data.user.photoURL?.absoluteString ?? "")
                    self.register(With: .loginWithGmail(userModel: loginModel))
                } else if let error = error {
                    let authError = error as NSError
                    if  authError.code == AuthErrorCode.secondFactorRequired.rawValue {
                        return
                    }
                    return
                }
            }
        }
    }
    
}

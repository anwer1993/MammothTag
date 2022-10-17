//
//  LoginWithApple.swift
//  MammothTag
//
//  Created by Anwar Hajji on 15/10/2022.
//

import Foundation
import AuthenticationServices
import FirebaseCore
import FirebaseAuth

extension SignInController: ASAuthorizationControllerDelegate {
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let nonce = Tools.randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = Tools.sha256(nonce)
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    /// - Tag: did_complete_authorization
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            Auth.auth().signIn(with: credential) {[weak self] (authResult, error) in
                guard  error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                guard let result = authResult else {return}
                var first_name: String  = ""
                var last_name: String = ""
                if let firstName = appleIDCredential.fullName?.givenName {
                    first_name = firstName
                } else {
                    first_name = (Auth.auth().currentUser?.displayName ?? "").subString().0
                }
                if let lastName = appleIDCredential.fullName?.familyName {
                    last_name = lastName
                } else {
                    last_name = (Auth.auth().currentUser?.displayName ?? "").subString().1
                }
                let email = (result.additionalUserInfo?.profile?["email"] as? String) ?? ""
                let loginModel = LoginWithSocialMediaModel(name: first_name, lastName: last_name, email: email, url_Picture: "")
                self?.register(With: .loginWithApple(userModel: loginModel))
            }
        }
    }
    
    /// - Tag: did_complete_error
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Sign in with Apple errored: \(error)")
    }
    
}

extension SignInController: ASAuthorizationControllerPresentationContextProviding {
    /// - Tag: provide_presentation_anchor
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}


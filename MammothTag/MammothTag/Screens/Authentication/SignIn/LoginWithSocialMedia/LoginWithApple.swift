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
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    /// - Tag: did_complete_authorization
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
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
                                                      rawNonce: Tools.randomNonceString())
            Auth.auth().signIn(with: credential) {[weak self] (authResult, error) in
                guard  error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                guard let result = authResult else {return}
                let first_name = result.user.displayName ?? ""
                let email = result.user.email ?? ""
                let profile_picture_url = result.user.photoURL?.absoluteString ?? ""
                let loginModel = LoginWithSocialMediaModel(name: first_name, lastName: "", email: email, url_Picture: profile_picture_url)
                self?.register(With: .loginWithApple(userModel: loginModel))
            }
        }
    }
    
    /// - Tag: did_complete_error
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
    
}

extension SignInController: ASAuthorizationControllerPresentationContextProviding {
    /// - Tag: provide_presentation_anchor
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}


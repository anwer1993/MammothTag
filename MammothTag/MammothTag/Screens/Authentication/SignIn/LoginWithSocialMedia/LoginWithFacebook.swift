//
//  LoginWithFacebook.swift
//  MammothTag
//
//  Created by Anwar Hajji on 14/10/2022.
//

import Foundation
import FBSDKLoginKit
import FBSDKCoreKit
import FirebaseCore
import FirebaseAuth



extension SignInController {
    
    @objc
    func loginWithFb() {
        LoginManager.init().logIn(viewController: self, configuration: LoginConfiguration(permissions: [Permission.publicProfile, Permission.email, Permission.publicProfile], tracking: LoginTracking.enabled)) { loginResult in
            switch loginResult {
            case .success(_, _, _):
                let requestedFields = "email, first_name, last_name, picture.type(large)"
                GraphRequest.init(graphPath: "me", parameters: ["fields":requestedFields]).start { (connection, result, error) -> Void in
                    if let result = result as? [String: Any] {
                        let name = result["first_name"] as? String
                        let last_name = result["last_name"] as? String
                        let email = result["email"] as? String
                        var profile_image_url = ""
                        if let picture = result["picture"] as? [String: Any?], let picture_data = picture["data"] as? [String: Any], let image_url = picture_data["url"] as? String {
                            profile_image_url = image_url
                        }
                        let loginModel = LoginWithSocialMediaModel(name: name ?? "", lastName: last_name ?? "", email: email ?? "", url_Picture: profile_image_url )
                        self.register(With: .loginWithFacebook(userModel: loginModel))
                    }
                }
            case .cancelled:
                print("Login: cancelled.")
            case .failed(let error):
                print("Login with error: \(error.localizedDescription)")
            }
        }
    }
}

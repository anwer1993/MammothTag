//
//  LoginType.swift
//  MammothTag
//
//  Created by Anwar Hajji on 13/10/2022.
//

import Foundation
import Alamofire
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

enum LoginType {
    
    case simpleLogin(userModel: RegisterModel)
    case loginWithGmail(userModel: LoginWithSocialMediaModel)
    case loginWithFacebook(userModel: LoginWithSocialMediaModel)
    case loginWithApple(userModel: LoginWithSocialMediaModel)
    case loginWithTwitter(userModel: LoginWithSocialMediaModel)
    
    var parameter: Parameters {
        switch self {
        case .simpleLogin(userModel: let userModel):
            if userModel.picture == nil {
                return ["name": userModel.firstName,
                        "username": userModel.LastName,
                        "birthday": userModel.dateOfBirth,
                        "phone": userModel.phone,
                        "email": userModel.email,
                        "password": userModel.password,
                        "login_with": "0"] as Parameters
            } else {
                return ["name": userModel.firstName,
                        "username": userModel.LastName,
                        "birthday": userModel.dateOfBirth,
                        "phone": userModel.phone,
                        "email": userModel.email,
                        "password": userModel.password,
                        "picture": userModel.picture!,
                        "login_with": 0] as Parameters
            }
        case .loginWithGmail(userModel: let userModel):
            return ["name": userModel.name,
                    "username": userModel.lastName,
                    "email": userModel.email,
                    "url_picture_social_network": userModel.url_Picture,
                    "login_with": 1] as Parameters
        case .loginWithFacebook(userModel: let userModel):
            return ["name": userModel.name,
                    "username": userModel.lastName,
                    "email": userModel.email,
                    "url_picture_social_network": userModel.url_Picture,
                    "login_with": 2] as Parameters
        case .loginWithApple(userModel: let userModel):
            return ["name": userModel.name,
                    "username": userModel.lastName,
                    "email": userModel.email,
                    "url_picture_social_network": userModel.url_Picture,
                    "login_with": 3] as Parameters
        case .loginWithTwitter(userModel: let userModel):
            return ["name": userModel.name,
                    "username": userModel.lastName,
                    "email": userModel.email,
                    "url_picture_social_network": userModel.url_Picture,
                    "login_with": 4] as Parameters
        }
    }
    
    func getAfParameter(userModel: LoginWithSocialMediaModel) -> Parameters {
        return ["name": userModel.name,
                "username": userModel.lastName,
                "email": userModel.email,
                "url_picture_social_network": userModel.url_Picture,
                "login_with": "1"] as Parameters
    }
    
}

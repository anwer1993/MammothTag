//
//  AuthenticationService.swift
//  MammothTag
//
//  Created by Anwar Hajji on 09/08/2022.
//

import Foundation
import Alamofire


class AuthenticationService {
    
    static var sharedInstance = AuthenticationService()
    
    func register(userModel: RegisterModel, completion: @escaping(ServerResponseModel<ProfileModel>) -> Void) {
        let parameters: Parameters?
        if userModel.picture == nil {
            parameters = ["name": userModel.firstName,
                                                "username": userModel.LastName,
                                                "birthday": userModel.dateOfBirth,
                                                "phone": userModel.phone,
                                                "email": userModel.email,
                                                "password": userModel.password] as Parameters
        } else {
            parameters = ["name": userModel.firstName,
                                                "username": userModel.LastName,
                                                "birthday": userModel.dateOfBirth,
                                                "phone": userModel.phone,
                                                "email": userModel.email,
                                                "password": userModel.password,
                                               "picture": userModel.picture!] as Parameters
        }
        
        AF.request(URLRequest.REGISTER_URL.url, method: .post, parameters: parameters).validate().responseDecodable(of: ServerResponseModel<ProfileModel>.self) { data in
            if let data = data.value {
                completion(data)
            }
        }
    }
    
    func login(loginModel: SignInModel, completion: @escaping(LoginServerResponseData) -> Void) {
        let parameters = ["email": loginModel.email,
                          "password": loginModel.password]
        AF.request(URLRequest.LOGIN_URL.url, method: .post, parameters: parameters).validate().responseDecodable(of: LoginServerResponseData.self) { data in
            if let data = data.value {
                completion(data)
            }
        }
        
    }
    
    func logout(token: String, completion: @escaping(LogoutServerResponseModel) -> Void) {
        AF.request("\(URLRequest.LOGOUT_URL.url)\(token)", method: .get).validate().responseDecodable(of: LogoutServerResponseModel.self) { data in
            if let data = data.value {
                completion(data)
            }
        }
    }
    
    func getSettings(completion: @escaping(ServerResponseModel<SettingsModel>) -> Void) {
        AF.request(URLRequest.SETTINGS.url, method: .get).validate().responseDecodable(of: ServerResponseModel<SettingsModel>.self) { data in
            if let data = data.value {
                completion(data)
            }
        }
    }
    
    func updatePassword(token: String, oldPassword: String, newPassword: String , completion: @escaping(ServerResponseModel<ProfileModel>) -> Void) {
        let parameters = ["password": newPassword,
                          "old_password": oldPassword] as Parameters
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request("\(URLRequest.UPDATE_PASSWORD.url)", method: .put, parameters: parameters, headers: headers).validate().responseDecodable(of: ServerResponseModel<ProfileModel>.self) { data in
            if let data = data.value {
                completion(data)
            }
        }
    }
    
    func forgotPassword(phone: String, completion: @escaping(ServerResponseModel<[ForgotPasswordModel]>) -> Void) {
        let parameters = ["phone": phone] as Parameters
        AF.request("\(URLRequest.FORGOT_PASSWORD.url)", method: .post, parameters: parameters).validate().responseDecodable(of: ServerResponseModel<[ForgotPasswordModel]>.self) { data in
            if let data = data.value {
                completion(data)
            }
        }
    }
    
    func changeForgotPassword(phone: String, code: String, password: String, completion: @escaping(ServerResponseModel<ForgotPasswordModel>) -> Void) {
        let parameters = ["phone": phone,
                          "code": code,
                          "password": password] as Parameters
        AF.request("\(URLRequest.CHANGE_FORGOT_PASSWORD.url)", method: .post, parameters: parameters).validate().responseDecodable(of: ServerResponseModel<ForgotPasswordModel>.self) { data in
            if let data = data.value {
                completion(data)
            }
        }
    }
    
    
    
    func getUserProfile(token: String, completion: @escaping(ProfileServerResponseModel?) -> Void) {
        AF.request("\(URLRequest.GET_USER_URL.url)\(token)", method: .get).validate().responseDecodable(of: ProfileServerResponseModel.self) { data in
            completion(data.value)
        }
    }
    
    func deactivateNFCTag(token: String, completion: @escaping(ProfileServerResponseModel?) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request("\(URLRequest.DEACTIVATE_NFC_URL.url)\(token)", method: .put, headers: headers).validate().responseDecodable(of: ProfileServerResponseModel.self) { data in
            completion(data.value)
        }
    }
    
    func activateNFCTag(nfc_tag: String, token: String, completion: @escaping(ProfileServerResponseModel?) -> Void) {
        let parameters = ["nfc_tag" : nfc_tag] as Parameters
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request("\(URLRequest.ACTIVATE_NFC_URL.url)\(token)", method: .put, parameters: parameters, headers: headers).validate().responseDecodable(of: ProfileServerResponseModel.self) { data in
            completion(data.value)
        }
    }
    
    func getUserByNFCTag(nfc_tag: String, token: String, completion: @escaping(ProfileServerResponseModel?) -> Void) {
        AF.request("\(URLRequest.USER_BY_NFC_URL.url)\(token)&nfc_tag=\(nfc_tag)", method: .get).validate().responseDecodable(of: ProfileServerResponseModel.self) { data in
            completion(data.value)
        }
    }
    
    func addUser(user_id: String, token: String, completion: @escaping(AddUserServerResponseModel?) -> Void) {
        let parameters = ["user_id" : user_id] as Parameters
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(URLRequest.ADD_USER_URL.url, method: .post, parameters: parameters, headers: headers).validate().responseDecodable(of: AddUserServerResponseModel.self) { data in
            completion(data.value)
        }

    }
    
    func updateUser(userModel: RegisterModel, token: String, completion: @escaping(ServerResponseModel<ProfileModel>) -> Void) {
        let parameters = ["name": userModel.firstName,
                          "username": userModel.LastName,
                          "birthday": userModel.dateOfBirth,
                          "phone": userModel.phone,
                          "email": userModel.email,
                          "password": userModel.password] as Parameters
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(URLRequest.UPDATE_USER_URL.url, method: .put, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: ServerResponseModel<ProfileModel>.self) { data in
            if let data = data.value {
                completion(data)
            }
        }
    }
    
}

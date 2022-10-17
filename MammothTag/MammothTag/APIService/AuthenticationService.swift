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
    
    func checkAppUpdateAvailability(onSuccess: @escaping (Bool) -> Void, onError: @escaping (Bool) -> Void) {
        guard let info = Bundle.main.infoDictionary,
              let curentVersion = info["CFBundleShortVersionString"] as? String,
              let url = URL(string: "http://itunes.apple.com/lookup?bundleId=com.MammothTag.123.MammothTag") else {
            return onError(true)
        }
        do {
            let data = try Data(contentsOf: url)
            guard let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] else {
                return onError(true)
            }
            if let result = (json["results"] as? [Any])?.first as? [String: Any], let appStoreVersion = result["version"] as? String {
                print("version in app store", appStoreVersion," current Version ",curentVersion);
                let versionCompare = curentVersion.compare(appStoreVersion, options: .numeric)
                if versionCompare == .orderedSame {
                    onSuccess(false)
                } else if versionCompare == .orderedAscending {
                    onSuccess(true)
                    // 2.0.0 to 3.0.0 is ascending order, so ask user to update
                } else {
                    onSuccess(false)
                }
            } else {
                onSuccess(false)
            }
        } catch {
            onError(true)
        }
    }
    
    func register(with loginType: LoginType, completion: @escaping(RegisterServerResponse) -> Void) {
        print(loginType.parameter)
        AF.request(URLRequest.REGISTER_URL.url, method: .post, parameters: loginType.parameter).validate().responseDecodable(of: RegisterServerResponse.self) { data in
            if let data = data.value {
                completion(data)
            }
        }
    }
    
    func register(userModel: RegisterModel, completion: @escaping(RegisterServerResponse) -> Void) {
        let parameters = ["name": userModel.firstName,
                          "username": userModel.LastName,
                          "birthday": userModel.dateOfBirth,
                          "phone": userModel.phone,
                          "email": userModel.email,
                          "password": userModel.password]
        AF.upload(multipartFormData: { multipartFormData in
            parameters.forEach { (key: String, value: String) in
                multipartFormData.append(value.data(using: .utf8) ?? Data(), withName: key)
            }
            if let picture = userModel.picture {
                multipartFormData.append(picture, withName: "picture", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            
        }, to: URLRequest.REGISTER_URL.url, method: .post)
        .validate()
        .responseDecodable(of: RegisterServerResponse.self) { data in
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
    
    func forgotPassword(email: String, completion: @escaping(ServerResponseModel<[ForgotPasswordModel]>) -> Void) {
        let parameters = ["email": email] as Parameters
        AF.request("\(URLRequest.FORGOT_PASSWORD.url)", method: .post, parameters: parameters).validate().responseDecodable(of: ServerResponseModel<[ForgotPasswordModel]>.self) { data in
            if let data = data.value {
                completion(data)
            }
        }
    }
    
    func changeForgotPassword(email: String, code: String, password: String, completion: @escaping(ServerResponseModel<ForgotPasswordModel>) -> Void) {
        let parameters = ["email": email,
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
    
    func activateNFCTag(nfc_tag: String, branch_link: String, token: String, completion: @escaping(ProfileServerResponseModel?) -> Void) {
        let parameters = ["nfc_tag" : nfc_tag,
                          "branch_link": branch_link] as Parameters
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
    
    func  deleteAccount(token: String, completion: @escaping(LoginServerResponseData?) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(URLRequest.DELETE_ACCOUNT_URL.url, method: .post, headers: headers).validate().responseDecodable(of: LoginServerResponseData.self) { data in
            completion(data.value)
        }
    }
    
    func updateUser(userModel: RegisterModel, token: String, completion: @escaping(ServerResponseModel<ProfileModel>) -> Void) {
        let parameters = ["name": userModel.firstName,
                          "username": userModel.LastName,
                          "birthday": userModel.dateOfBirth,
                          "phone": userModel.phone,
                          "email": userModel.email,
                          "password": userModel.password]
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.upload(multipartFormData: { multipartFormData in
            parameters.forEach { (key: String, value: String) in
                multipartFormData.append(value.data(using: .utf8) ?? Data(), withName: key)
            }
            if let picture = userModel.picture {
                multipartFormData.append(picture, withName: "picture", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            
        }, to: URLRequest.UPDATE_USER_URL.url, method: .post, headers: headers)
        .validate()
        .responseDecodable(of: ServerResponseModel<ProfileModel>.self.self) { data in
            if let data = data.value {
                completion(data)
            }
        }
    }
    
}

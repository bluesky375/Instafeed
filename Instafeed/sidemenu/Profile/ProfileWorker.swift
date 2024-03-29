//
//  ProfileWorker.swift
//  Instafeed
//
//  Created by A1GEISP7 on 07/09/19.
//  Copyright (c) 2019 gulam ali. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class ProfileWorker
{
  func getProfileData(completionHandler: @escaping (_ data: Profiledata?, _ error: errorModel?) -> Void)
  {
    let api = ServerURL.firstpoint + ServerURL.Getprofile
    guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
    let params = ["token":UserToken] as [String:Any]
    networking.MakeRestRequest(Url: api, Param: params) { (result:ProfileDataModel?) in
        if let message = result?.message, message == "success"{
            guard let response = result?.data else {return}
            completionHandler(response, nil)
        }else{
            completionHandler(nil, errorModel(message: "error"))
        }
    }
  }
    
    func updateProfile(profileData:Profiledata , completionHandler: @escaping (_ data: errorModel?, _ error: errorModel?) -> Void){
        let api = ServerURL.firstpoint + ServerURL.updateProfile
        guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
        let params = ["token":UserToken, "first_name": profileData.first_name as Any, "middle_name": profileData.middle_name as Any, "last_name": profileData.last_name as Any, "username": profileData.username as Any, "birth_date":profileData.birth_date as Any, "sex": profileData.sex as Any, "location_id":"1", "bio": profileData.bio as Any, "website": profileData.website as Any, "phone": profileData.phone as Any, "bank_name": profileData.bank_name as Any, "bank_ifsc_code": profileData.bank_ifsc_code as Any, "bank_acc_type": profileData.bank_acc_type as Any, "bank_acc_no": profileData.bank_acc_no as Any, "pincode": profileData.pincode as Any, "address": profileData.address as Any, "city": profileData.city as Any, "lat": profileData.lat as Any, "long": profileData.long as Any] as [String:Any]
        networking.MakeRestRequest(Url: api, Param: params) { (result:errorModel?) in
            if let message = result?.message, message == "success"{
                
                completionHandler(errorModel(message: "success"), nil)
            }else{
                completionHandler(nil, errorModel(message: "error"))
            }
        }
    }
    
    func updatePic(profilepic:UIImage , completionHandler: @escaping (_ data: imageUpdationResultModel?, _ error: errorModel?) -> Void){
        let api = ServerURL.firstpoint + ServerURL.updateProfilePic
        guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
        let params = ["token":UserToken]
        
        networking.uploadImagesAndData(Api: api, params: params, imagepost: [profilepic], completion: { (response, error ) in
            
            if let message = response?.message, message == "success"{
                
                completionHandler(imageUpdationResultModel(message: "success", image: profilepic), nil)
            }else{
                completionHandler(nil, errorModel(message: "error"))
            }
            
        })
    }
    
    func deletePic(completionHandler: @escaping (_ data: errorModel?, _ error: errorModel?) -> Void){
        let api = ServerURL.firstpoint + ServerURL.removeProfilePic
        guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
        let params = ["token":UserToken]
        networking.MakeRestRequest(Url: api, Param: params) { (result: errorModel?) in
            if let message = result?.message, message == "success"{
                completionHandler(errorModel(message: "success"), nil)
            }else{
                completionHandler(nil, errorModel(message: "error"))
            }
        }
    }
}


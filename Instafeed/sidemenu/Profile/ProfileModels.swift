//
//  ProfileModels.swift
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

enum Profile
{
  // MARK: Use cases
  
  enum ProfileData
  {
    struct Request
    {
        var data = Profiledata()
        var profilePic = UIImage()
    }
    struct Response
    {
        var data = Profiledata()
        var updateResult = errorModel()
        var deleteResult = errorModel()
        var profilepicResult = imageUpdationResultModel()
    }
    struct ViewModel
    {
        var profileData = ProfileViewModel()
        var data = Profiledata()
        var result = errorModel()
        var removePicResult = errorModel()
        var updatedProfilePicResult = imageUpdationResultModel()
    }
  }
}

struct ProfileViewModel {
    var user_id:String?
    var username:String?
    var profile_url:String?
    var email:String?
    var avatar:String?
    var first_name:String?
    var middle_name:String?
    var last_name:String?
    var address:String?
    var pincode:String?
    var city:String?
    var bank_ifsc_code:String?
    var bank_acc_type:String?
    var bank_acc_no:String?
    var bank_name:String?
    var phone:String?
    var sex:String?
    var birth_date:String?
}

struct errorModel: Decodable {
    var message:String?
}

struct imageUpdationResultModel {
    var message:String?
    var image:UIImage?
}
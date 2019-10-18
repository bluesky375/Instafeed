//
//  networking.swift
//  mvvm
//
//  Created by gulam ali on 16/06/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit
import Alamofire
import ProgressHUD
import CoreLocation
import Network


class networking: NSObject {
    
    class func SignUpUser(Url:String,Param:[String:Any],completion:@escaping (signup?, Error?)->()){
        
        ProgressHUD.show()
        guard let myUrl = URL(string: Url) else{ return}
        
        Alamofire.request(myUrl, method: .post, parameters: Param as Parameters).responseJSON { (closureResponse) in
            
            print(closureResponse)
            
            switch closureResponse.result{
                
            case .success:
                print("succeess")
                //hide loader
                if closureResponse.result.value != nil{
                    ProgressHUD.dismiss()
                    if closureResponse.response?.statusCode == 401{
                        self.switchToLogin()
                    }else{
                        do{
                            if let resp = closureResponse.data{
                                let data = try JSONDecoder().decode(signup.self, from: resp)
                                print(data)
                                completion(data,nil)
                            }else{
                                Toast().showToast(message: "Something went wrong!!!", duration: 2)
                            }
                            
                        }catch{
                            print("catched error in do try")
                            completion(nil,error)
                        }
                    }
                }else{
                    print("values are nil")
                     ProgressHUD.dismiss()
                  completion(nil,closureResponse.error)
                }
                
            case .failure(let err):
                 ProgressHUD.dismiss()
                print("got an error while making request -> \(err)")
               completion(nil,err)
            }
            
        }
    }
    
    
    class func LoginUser(Url:String,Param:[String:Any],completion:@escaping (Login?, Error?)->()){
        
        ProgressHUD.show()
        guard let myUrl = URL(string: Url) else{ return}
        
        Alamofire.request(myUrl, method: .post, parameters: Param as Parameters).responseJSON { (closureResponse) in
            
            print(closureResponse)
            
            switch closureResponse.result{
                
            case .success:
                print("succeess")
                /*if closureResponse.response?.statusCode == 401{
                    self.switchToLogin()
                }else{*/
                    //hide loader
                    if closureResponse.result.value != nil{
                        ProgressHUD.dismiss()
                        do{
                            if let resp = closureResponse.data{
                                let data = try JSONDecoder().decode(Login.self, from: resp)
                                print(data)
                                completion(data,nil)
                            }else{
                                Toast().showToast(message: "Something went wrong!!!", duration: 2)
                            }
                        }catch{
                            print("catched error in do try")
                            completion(nil,error)
                        }
                        
                    }else{
                        print("values are nil")
                        ProgressHUD.dismiss()
                        completion(nil,closureResponse.error)
                    }
               // }
            case .failure(let err):
                ProgressHUD.dismiss()
                print("got an error while making request -> \(err)")
                completion(nil,err)
            }
            
        }
    }
    
    
    //forgot password
    
    class func forgotPassword(Url:String,Param:[String:Any],completion:@escaping (ForgotPassword?, Error?)->()){
        
        ProgressHUD.show()
        guard let myUrl = URL(string: Url) else{ return}
        
        Alamofire.request(myUrl, method: .post, parameters: Param as Parameters).responseJSON { (closureResponse) in
            
            print(closureResponse)
            
            switch closureResponse.result{
                
            case .success:
                print("succeess")
                if closureResponse.response?.statusCode == 401{
                    self.switchToLogin()
                }else{
                    //hide loader
                    if closureResponse.result.value != nil{
                        ProgressHUD.dismiss()
                        do{
                            if let resp = closureResponse.data{
                                let data = try JSONDecoder().decode(ForgotPassword.self, from: resp)
                                print(data)
                                completion(data,nil)
                            }else{
                                Toast().showToast(message: "Something went wrong!!!", duration: 2)
                            }
                        }catch{
                            print("catched error in do try")
                            completion(nil,error)
                        }
                        
                    }else{
                        print("values are nil")
                        ProgressHUD.dismiss()
                        completion(nil,closureResponse.error)
                    }
                }
            case .failure(let err):
                ProgressHUD.dismiss()
                print("got an error while making request -> \(err)")
                completion(nil,err)
            }
            
        }
    }
    
    
    class func signInusingMobile(Url:String,Param:[String:Any],completion:@escaping (sendOTP?, Error?)->()){
        
        ProgressHUD.show()
        guard let myUrl = URL(string: Url) else{ return}
        
        Alamofire.request(myUrl, method: .post, parameters: Param as Parameters).responseJSON { (closureResponse) in
            
            print(closureResponse)
            
            switch closureResponse.result{
                
            case .success:
                print("succeess")
                if closureResponse.response?.statusCode == 401{
                    self.switchToLogin()
                }else{
                    //hide loader
                    if closureResponse.result.value != nil{
                        ProgressHUD.dismiss()
                        do{
                            if let resp = closureResponse.data{
                                let data = try JSONDecoder().decode(sendOTP.self, from: resp)
                                print(data)
                                completion(data,nil)
                            }else{
                                Toast().showToast(message: "Something went wrong!!!", duration: 2)
                            }
                        }catch{
                            print("catched error in do try")
                            completion(nil,error)
                        }
                        
                    }else{
                        print("values are nil")
                        ProgressHUD.dismiss()
                        completion(nil,closureResponse.error)
                    }
                }
            case .failure(let err):
                ProgressHUD.dismiss()
                print("got an error while making request -> \(err)")
                completion(nil,err)
            }
            
        }
    }
    
    class func VerifyOTP(Url:String,Param:[String:Any],completion:@escaping (verifyOTP?, Error?)->()){
        
        ProgressHUD.show()
        guard let myUrl = URL(string: Url) else{ return}
        
        Alamofire.request(myUrl, method: .post, parameters: Param as Parameters).responseJSON { (closureResponse) in
            
            print(closureResponse)
            
            switch closureResponse.result{
                
            case .success:
                print("succeess")
                if closureResponse.response?.statusCode == 401{
                    self.switchToLogin()
                }else{
                    //hide loader
                    if closureResponse.result.value != nil{
                        ProgressHUD.dismiss()
                        do{
                            if let resp = closureResponse.data{
                                let data = try JSONDecoder().decode(verifyOTP.self, from: resp)
                                print(data)
                                completion(data,nil)
                            }else{
                                Toast().showToast(message: "Something went wrong!!!", duration: 2)
                            }
                            
                        }catch{
                            print("catched error in do try")
                            completion(nil,error)
                        }
                        
                    }else{
                        print("values are nil")
                        ProgressHUD.dismiss()
                        completion(nil,closureResponse.error)
                    }
                }
            case .failure(let err):
                ProgressHUD.dismiss()
                print("got an error while making request -> \(err)")
                completion(nil,err)
            }
            
        }
    }
    
    
    class func SocialLogin(Url:String,Param:[String:Any],completion:@escaping (socialLogin?, Error?)->()){
        
        ProgressHUD.show()
        guard let myUrl = URL(string: Url) else{ return}
        
        Alamofire.request(myUrl, method: .post, parameters: Param as Parameters).responseJSON { (closureResponse) in
            
            print(closureResponse)
            
            switch closureResponse.result{
                
            case .success:
                print("succeess")
                if closureResponse.response?.statusCode == 401{
                    self.switchToLogin()
                }else{
                    //hide loader
                    if closureResponse.result.value != nil{
                        ProgressHUD.dismiss()
                        do{
                            if let resp = closureResponse.data{
                                let data = try JSONDecoder().decode(socialLogin.self, from: resp)
                                print(data)
                                completion(data,nil)
                            }else{
                                Toast().showToast(message: "Something went wrong!!!", duration: 2)
                            }
                            
                        }catch{
                            print("catched error in do try")
                            completion(nil,error)
                        }
                        
                    }else{
                        print("values are nil")
                        ProgressHUD.dismiss()
                        completion(nil,closureResponse.error)
                    }
                }
            case .failure(let err):
                ProgressHUD.dismiss()
                print("got an error while making request -> \(err)")
                completion(nil,err)
            }
            
        }
    }
    
    
    
    class func Citizentab_Recents(Url:String,Param:[String:Any]?,vc:UIViewController,completion:@escaping (citizenRecents?, Error?)->()){
        
        if connectivity.isconnectedToInternet{
            ProgressHUD.show()
            guard let myUrl = URL(string: Url) else{ return}
            
            Alamofire.request(myUrl, method: .post, parameters: Param).responseJSON { (closureResponse) in
                
                print(closureResponse)
                
                switch closureResponse.result{
                    
                case .success:
                    print("succeess")
                    
                    if closureResponse.response?.statusCode == 401{
                        self.switchToLogin()
                    }else{
                        //hide loader
                        if closureResponse.result.value != nil{
                            ProgressHUD.dismiss()
                            do{
                                if let resp = closureResponse.data{
                                    let data = try JSONDecoder().decode(citizenRecents.self, from: resp)
                                    print(data)
                                    completion(data,nil)
                                }else{
                                    Toast().showToast(message: "Something went wrong!!!", duration: 2)
                                }
                            }catch{
                                print("catched error in do try")
                                completion(nil,error)
                            }
                            
                        }else{
                            print("values are nil")
                            ProgressHUD.dismiss()
                            completion(nil,closureResponse.error)
                        }
                    }
                case .failure(let err):
                    ProgressHUD.dismiss()
                    print("got an error while making request -> \(err)")
                    completion(nil,err)
                }
                
            }
        }else{
            CommonFuncs.NoInternetAlert(vc: vc)
        }
  
    }
    
    
    class func Citizentab_Feeds(Url:String,Param:[String:Any]?,vc:UIViewController,completion:@escaping (citizenFeeds?, Error?)->()){
        
        if connectivity.isconnectedToInternet{
            print("Connected to internet")
            ProgressHUD.show()
            guard let myUrl = URL(string: Url) else{ return}
            
            Alamofire.request(myUrl, method: .post, parameters: Param).responseJSON { (closureResponse) in
                
                print(closureResponse)
                
                switch closureResponse.result{
                    
                case .success:
                    print("succeess")
                    if closureResponse.response?.statusCode == 401{
                        self.switchToLogin()
                    }else{
                        //hide loader
                        if closureResponse.result.value != nil{
                            ProgressHUD.dismiss()
                            do{
                                if let resp = closureResponse.data{
                                    let data = try JSONDecoder().decode(citizenFeeds.self, from: resp)
                                    print(data)
                                    completion(data,nil)
                                }else{
                                    Toast().showToast(message: "Something went wrong!!!", duration: 2)
                                }
                            }catch{
                                print("catched error in do try")
                                completion(nil,error)
                            }
                            
                        }else{
                            print("values are nil")
                            ProgressHUD.dismiss()
                            completion(nil,closureResponse.error)
                        }
                    }
                case .failure(let err):
                    ProgressHUD.dismiss()
                    print("got an error while making request -> \(err)")
                    completion(nil,err)
                }
                
            }
        }else{
            CommonFuncs.NoInternetAlert(vc: vc)
        }
        
      
    }
    
    
    class func MakeRequest<T: Decodable>(Url:String,Param:[String:Any]?,vc:UIViewController,completion:@escaping (_ String: T) -> ()) {
        
        if connectivity.isconnectedToInternet {
            print("Connected to internet")
            ProgressHUD.show()
            guard let myUrl = URL(string: Url) else{ return}
            
            Alamofire.request(myUrl, method: .post, parameters: Param).responseJSON { (closureResponse) in
                
                print(closureResponse)
                
                switch closureResponse.result {
                    
                case .success:
                    print("succeess")
                    if closureResponse.response?.statusCode == 401 {
                        self.switchToLogin()
                    } else {
                        //hide loader
                        if closureResponse.result.value != nil {
                            ProgressHUD.dismiss()
                            do {
                                if let resp = closureResponse.data {
                                    
                                    let data = try JSONDecoder().decode(T.self, from: resp)
                                    print(data)
                                    completion(data)
                                } else {
                                    
                                    Toast().showToast(message: "Something went wrong!!!", duration: 2)
                                }
                                
                            } catch {
                                print("catched error in do try")
                                print(error)
                            }
                            
                        } else {
                            print("values are nil")
                            ProgressHUD.dismiss()
                            CommonFuncs.AlertWithOK(msg: "Got an error, Try again later", vc: vc)
                            return
                        }
                    }
                case .failure(let err):
                    ProgressHUD.dismiss()
                    print("got an error while making request -> \(err)")
                    CommonFuncs.AlertWithOK(msg: "Got an error, Try again later", vc: vc)
                }
                
            }
        }else{
            CommonFuncs.NoInternetAlert(vc: vc)
        }
        
        
    }
    
    class func MakeGetRequest<T: Decodable>(Url:String,Param:[String:Any]?,vc:UIViewController,completion:@escaping (_ String: T) -> ()) {
        
        if connectivity.isconnectedToInternet {
            print("Connected to internet")
            ProgressHUD.show()
            guard let myUrl = URL(string: Url) else{ return}
            
            Alamofire.request(myUrl, method: .get, parameters: Param,   encoding: URLEncoding.httpBody).responseJSON { (closureResponse) in
                
                print(closureResponse)
                
                switch closureResponse.result {
                    
                case .success:
                    print("succeess")
                    if closureResponse.response?.statusCode == 401 {
                        self.switchToLogin()
                    } else {
                        //hide loader
                        if closureResponse.result.value != nil {
                            ProgressHUD.dismiss()
                            do {
                                if let resp = closureResponse.data {
                                    
                                    let data = try JSONDecoder().decode(T.self, from: resp)
                                    print(data)
                                    completion(data)
                                } else {
                                    
                                    Toast().showToast(message: "Something went wrong!!!", duration: 2)
                                }
                                
                            } catch {
                                print("catched error in do try")
                                print(error)
                            }
                            
                        } else {
                            print("values are nil")
                            ProgressHUD.dismiss()
                            CommonFuncs.AlertWithOK(msg: "Got an error, Try again later", vc: vc)
                            return
                        }
                    }
                case .failure(let err):
                    ProgressHUD.dismiss()
                    print("got an error while making request -> \(err)")
                    CommonFuncs.AlertWithOK(msg: "Got an error, Try again later", vc: vc)
                }
                
            }
        }else{
            CommonFuncs.NoInternetAlert(vc: vc)
        }
        
        
    }
    
    class func MakeRestRequest<T: Decodable>(Url:String,Param:[String:Any]?,completion:@escaping ((T)?) -> ()){
        
        if connectivity.isconnectedToInternet{
            print("Connected to internet")
            ProgressHUD.show()
            guard let myUrl = URL(string: Url) else{ return}
            
            Alamofire.request(myUrl, method: .post, parameters: Param).responseJSON { (closureResponse) in
                
                print(closureResponse)
                
                switch closureResponse.result{
                    
                case .success:
                    print("succeess")
                    if closureResponse.response?.statusCode == 401{}else{
                        //hide loader
                        if closureResponse.result.value != nil{
                            ProgressHUD.dismiss()
                            if closureResponse.response?.statusCode == 401{
                                self.switchToLogin()
                            }else{
                                do{
                                    if let resp = closureResponse.data{
                                        let data = try JSONDecoder().decode(T.self, from: resp)
                                        print(data)
                                        completion(data)
                                    }else{
                                        Toast().showToast(message: "Something went wrong!!!", duration: 2)
                                    }
                                }catch{
                                    completion(nil)
                                    return
                                }
                            }
                            
                            
                        }else{
                            print("values are nil")
                            //ProgressHUD.dismiss()
                            completion(nil)
                            //CommonFuncs.AlertWithOK(msg: "Got an error, Try again later", vc: vc)
                            return
                        }
                    }
                case .failure(let err):
                    ProgressHUD.dismiss()
                    print("got an error while making request -> \(err)")
                    Toast().showToast(message: err.localizedDescription, duration: 2)
                    //CommonFuncs.AlertWithOK(msg: "Got an error, Try again later", vc: vc)
                }
                
            }
        }else{
            Toast().showToast(message: "No Inernet Access", duration: 2)
            //CommonFuncs.NoInternetAlert(vc: vc)
        }
        
        
    }
    
    //MARK: - upload multiple photos
    
    
    
   class func uploadImagesAndData(Api:String,params:[String : Any]?,imagepost: [UIImage], completion:@escaping (postimage?, Error?)->()) -> Void {
    
    ProgressHUD.show()
    var imagesData: [Data] = []
    for imgPost in imagepost {
        let imageData1 = imgPost.jpegData(compressionQuality: 0.9)!
        imagesData.append(imageData1)
    }
    
    print(params!)
   // print(imageData1)
    
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            for (index, imageData) in imagesData.enumerated() {
                multipartFormData.append(imageData, withName: "image\(index + 1)", fileName: "image\(index + 1).jpeg", mimeType: "image/jpeg")
            }
            
            for (key, value) in params! {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }

            
            
        },
                         to: Api, encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload
                                    .validate()
                                    .responseJSON { response in
                                        switch response.result {
                                        case .success(let value):
                                            print("responseObject: \(value)")
                                            ProgressHUD.dismiss()
                                            if response.response?.statusCode == 401{
                                                self.switchToLogin()
                                            }else{
                                                do{
                                                    if let resp = response.data {
                                                        let data = try JSONDecoder().decode(postimage.self, from: resp)
                                                        print(data)
                                                        completion(data,nil)
                                                    }else{
                                                        Toast().showToast(message: "Something went wrong!!!", duration: 2)
                                                    }
                                                }catch{
                                                    print("catched error in do try")
                                                    completion(nil,error)
                                                }
                                            }
                                        case .failure(let responseError):
                                            ProgressHUD.dismiss()
                                            print("responseError: \(responseError)")
                                        }
                                }
                            case .failure(let encodingError):
                                ProgressHUD.dismiss()
                                print("encodingError: \(encodingError)")
                            }
        })
    }
    
    
    
    
    
    //MARK:>>>>>> Send audio to server
    
    class func uploadAudio(Api:String,params:[String : AnyObject]?,audio: URL, completionHandler:@escaping (FollowUserModel?, Error?)->()) -> Void {
        
        var audioData: Data?
        do {
            audioData = try Data(contentsOf: audio, options: Data.ReadingOptions.alwaysMapped)
        } catch _ {
            audioData = nil
            
        }

        
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            for (key, value) in params! {
                if let data = value.data(using: String.Encoding.utf8.rawValue) {
                    multipartFormData.append(data, withName: key)
                }
            }
            
            guard let voice = audioData else{return}
            
             multipartFormData.append(voice, withName: "audio", fileName: "recording.m4a", mimeType: "audio/x-m4a")
            
        },
                         to: Api, encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload
                                    .validate()
                                    .responseJSON { response in
                                        switch response.result {
                                        case .success(let value):
                                            if response.response?.statusCode == 401{
                                                self.switchToLogin()
                                            }else{
                                                print("responseObject: \(value)")
                                                completionHandler(FollowUserModel(message: "success"), nil)
                                            }
                                        case .failure(let responseError):
                                            print("responseError: \(responseError)")
                                        }
                                }
                            case .failure(let encodingError):
                                print("encodingError: \(encodingError)")
                            }
        })
    }
    
    //MARK:>>>>>> Send Video to server
    
    class func uploadVideo(Api:String,params:[String : AnyObject]?,video: [URL], completionHandler:@escaping (FollowUserModel?, Error?)->()) -> Void {
                          
    var moviesData: [Data] = []
    for vid in video {
        do {
           let mData = try Data(contentsOf: vid, options: Data.ReadingOptions.alwaysMapped)
            moviesData.append(mData)
        } catch _ {
        }
    }
        

      
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            for (key, value) in params! {
                if let data = value.data(using: String.Encoding.utf8.rawValue) {
                    multipartFormData.append(data, withName: key)
                }
            }
            
           for (index, movie) in moviesData.enumerated() {
                         
                     multipartFormData.append(movie, withName: "video\(index + 1)", fileName: "upload\(index + 1).mp4", mimeType: "video/mp4")
                     
            }
            
         
            
        },
                         to: Api, encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload
                                    .validate()
                                    .responseJSON { response in
                                        switch response.result {
                                        case .success(let value):
                                            if response.response?.statusCode == 401{
                                                self.switchToLogin()
                                            }else{
                                                print("responseObject: \(value)")
                                                completionHandler(FollowUserModel(message: "success"), nil)
                                            }
                                        case .failure(let responseError):
                                            print("responseError: \(responseError)")
                                        }
                                }
                            case .failure(let encodingError):
                                print("encodingError: \(encodingError)")
                            }
        })
        
        }
    
    class func uploadVideoANDImage(Api:String,params:[String : AnyObject]?,video: [URL],imagepost: [UIImage], completionHandler:@escaping (FollowUserModel?, Error?)->()) -> Void {
                          
    var moviesData: [Data] = []
    for vid in video {
        do {
           let mData = try Data(contentsOf: vid, options: Data.ReadingOptions.alwaysMapped)
            moviesData.append(mData)
        } catch _ {
        }
    }
        
    var imagesData: [Data] = []
      for imgPost in imagepost {
          let imageData1 = imgPost.jpegData(compressionQuality: 0.9)!
          imagesData.append(imageData1)
      }
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            for (key, value) in params! {
                if let data = value.data(using: String.Encoding.utf8.rawValue) {
                    multipartFormData.append(data, withName: key)
                }
            }
            
           for (index, movie) in moviesData.enumerated() {
                         
                     multipartFormData.append(movie, withName: "video\(index + 1)", fileName: "upload\(index + 1).mp4", mimeType: "video/mp4")
                     
            }
            
            for (index, imageData) in imagesData.enumerated() {
                         multipartFormData.append(imageData, withName: "image\(index + 1)", fileName: "image\(index + 1).jpeg", mimeType: "image/jpeg")
                     }
            
        },
                         to: Api, encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload
                                    .validate()
                                    .responseJSON { response in
                                        switch response.result {
                                        case .success(let value):
                                            if response.response?.statusCode == 401{
                                                self.switchToLogin()
                                            }else{
                                                print("responseObject: \(value)")
                                                completionHandler(FollowUserModel(message: "success"), nil)
                                            }
                                        case .failure(let responseError):
                                            print("responseError: \(responseError)")
                                        }
                                }
                            case .failure(let encodingError):
                                print("encodingError: \(encodingError)")
                            }
        })
        
        }
    class func switchToLogin(){
        
        Toast().showToast(message: "Session has expired please try loging in again!!!", duration: 2)
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
        UserDefaults.standard.userLoggedIn(value: false)
        //remove all the vc's
            if let vc = appDelegate.window?.topMostController() as? ViewController{
                vc.navigationController?.viewControllers.removeAll()
            }
        constnt.appDelegate.rootlogin()
        }
    }

}  // end of class







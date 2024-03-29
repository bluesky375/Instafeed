//
//  CommonFuncs.swift
//  Consta-Cab
//
//  Created by gulam ali on 28/05/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit

class CommonFuncs: NSObject {

    //MARK >>>> PHONE NUMBER REGEX
   class func validate(value: String) -> Bool {
        let PHONE_REGEX = "^([+][9][1]|[9][1]|[0]){0,1}([7-9]{1})([0-9]{9})$"  //for 10 digit no.only and no.shoud start with 7 8 9
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    //MARK:>>> Alert with ok btn to dismiss
    class func AlertWithOK(msg:String,vc:UIViewController){
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        vc.present(alert, animated: true, completion: nil)
    }
    
    class func AlertWithOK(msg:String,vc:UIViewController, complitionHandler: @escaping (Bool) -> ()){
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
       
        alert.addAction(OKAction)
        vc.present(alert, animated: true, completion: {
            complitionHandler(true)
        })
    }
    
    class func AlertWithActions(msg:String,vc:UIViewController,yestapped:@escaping()->()){
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        
        let yes = UIAlertAction(title: "Yes", style: .default) { (alertaction) in
            yestapped()
        }
        alert.addAction(yes)
        let no = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(no)
        vc.present(alert, animated: true, completion: nil)
    }
    
    class func NoInternetAlert(vc:UIViewController){
        let alert = UIAlertController(title: "No Internet !!", message: "Found network problem, Please check your data or wifi connection", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        vc.present(alert, animated: true, completion: nil)
    }
    
    
    class func CallActionsheet(vc:UIViewController,bookmarkAction:@escaping()->()){
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let bookmark = UIAlertAction(title: "Bookmark", style: .default) { action -> Void in
            bookmarkAction()
        }
        //btnCamera.setValue(UIImage(named:"camera-icon"), forKey: "image")
         bookmark.setValue(UIColor(hexValue: InstafeedColors.ThemeOrange), forKey: "titleTextColor")
        actionSheetController.addAction(bookmark)
        
        let More = UIAlertAction(title: "More", style: .default) { action -> Void in
           // self.openGallery()
        }
        //btnGallery.setValue(UIImage(named:"gallery-icon"), forKey: "image")
        More.setValue(UIColor(hexValue: InstafeedColors.ThemeOrange), forKey: "titleTextColor")
        actionSheetController.addAction(More)
        
        let btnCancel = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        
        btnCancel.setValue(UIColor.red, forKey: "titleTextColor")
        actionSheetController.addAction(btnCancel)
        
        
        //fix for ipad
        if let popoverController = actionSheetController.popoverPresentationController {
            popoverController.sourceView = vc.view
            popoverController.sourceRect = CGRect(x: vc.view.bounds.midX, y: vc.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        
        vc.present(actionSheetController, animated: true, completion: nil)
    }
    
    class func HitactionSheet(vc:UIViewController,title1:String,title1action:@escaping ()->(),title2:String,title2action:@escaping ()->()){
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let bookmark = UIAlertAction(title: title1, style: .default) { action -> Void in
            title1action()
        }
        //btnCamera.setValue(UIImage(named:"camera-icon"), forKey: "image")
        bookmark.setValue(UIColor(hexValue: InstafeedColors.ThemeOrange), forKey: "titleTextColor")
        actionSheetController.addAction(bookmark)
        
        let More = UIAlertAction(title: title2, style: .default) { action -> Void in
            // self.openGallery()
            title2action()
        }
        //btnGallery.setValue(UIImage(named:"gallery-icon"), forKey: "image")
        More.setValue(UIColor(hexValue: InstafeedColors.ThemeOrange), forKey: "titleTextColor")
        actionSheetController.addAction(More)
        
        let btnCancel = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        
        btnCancel.setValue(UIColor.red, forKey: "titleTextColor")
        actionSheetController.addAction(btnCancel)
        
        
        //fix for ipad
        if let popoverController = actionSheetController.popoverPresentationController {
            popoverController.sourceView = vc.view
            popoverController.sourceRect = CGRect(x: vc.view.bounds.midX, y: vc.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        
        vc.present(actionSheetController, animated: true, completion: nil)
    }
    
    //MARK::: ADD BOOKMARK API CALL
    
    class func addbookmark(url: String, vc:UIViewController,postid:String,token:String, moduleId:String, completionHandler: @escaping (_ result: addBookmark?, _ error: Error?) -> Void){
        let api = ServerURL.firstpoint + url
        let params = ["token":token,"id":postid,"module_id":moduleId] as [String:Any]
        networking.MakeRequest(Url: api, Param: params, vc: vc) { (result:addBookmark) in
            print(result)
            if result.message == "success"{
                //successfully added bookmark
                completionHandler(result, nil)
                
            }else{
                CommonFuncs.AlertWithOK(msg: result.message, vc: vc)
                return
            }
        }
    }
    
    
    class func spammarked(url: String, vc:UIViewController,postid:String,token:String, moduleId:String, reasonId:String, completionHandler: @escaping (_ result: addBookmark?, _ error: Error?) -> Void){
        let api = ServerURL.firstpoint + url
        let params = ["token":token,"id":postid,"module_id":moduleId, "reason_id":reasonId] as [String:Any]
        networking.MakeRequest(Url: api, Param: params, vc: vc) { (result:addBookmark) in
            print(result)
            if result.message == "success"{
                //successfully added bookmark
                completionHandler(result, nil)
                
            }else{
                CommonFuncs.AlertWithOK(msg: result.message, vc: vc)
                return
            }
        }
    }
    class func addfollow(url: String,username:String ,vc:UIViewController,postid:String,token:String, moduleId:String, completionHandler: @escaping (_ result: addBookmark?, _ error: Error?) -> Void){
        let api = ServerURL.firstpoint + url
        let params = ["token":token,"id":postid,"module_id":moduleId, "username":username] as [String:Any]
        networking.MakeRequest(Url: api, Param: params, vc: vc) { (result:addBookmark) in
            print(result)
            if result.message == "success"{
                //successfully added bookmark
                completionHandler(result, nil)
                
            }else{
                CommonFuncs.AlertWithOK(msg: result.message, vc: vc)
                return
            }
        }
    }
    static func CheckNullString(value : AnyObject) -> String{
        var str = String.init(format: "%ld", value as! CVarArg)
        if let v = value as? NSString {
            str = v as String
        } else if let v = value as? NSNumber {
            str = v.stringValue
        } else if let v = value as? Double {
            str = String.init(format: "%ld", v)
        } else if let v = value as? Int{
            str = String.init(format: "%ld", v)
        } else if value is NSNull{
            str = "";
        } else {
            str = ""
        }
        return str
    }
}

//
//  Constatnts.swift
//  Instafeed
//
//  Created by gulam ali on 19/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import Foundation
import UIKit


struct constnt {
    
    static let fbApp_id:String = "478526966242222"
    static let Google_key:String = "569566651528-pvkpiosavf3kb6spoai8fbismiqo43d5.apps.googleusercontent.com"
    
    static let googleMapsKey = "AIzaSyC3haQgdTlH8QxAo7OsB6szbXghIqsZT3c"
//AIzaSyC3haQgdTlH8QxAo7OsB6szbXghIqsZT3c
    
  static let appDelegate =  UIApplication.shared.delegate as! AppDelegate
    
}

struct Alertmsg {
    static let wentwrong:String = "Something went wrong,Try again later"
}

struct ServerURL {
    
    static let firstpoint:String = "http://13.234.116.90/api/"
    
    //MARK:>>>>>> endpoints
    
    //Authentication
    static let signup:String = "signup"
    static let login:String = "login"
    static let forgetPassword = "forgot"
    static let sendOTP = "signup/otp"
    static let VerifyOTP = "signup/otp/verify"
    static let socialLogin = "social"
    static let changePassword = "change_password"
    static let addfollow = "profile/public/follow"
    static let unfollow = "profile/public/unfollow"
    static let blockUser = "profile/public/unfollow"
    static let singleprofile = "profile/public"
    static let userpost = "profile/public/news"
    static let brandprofile = "brands/info"
    static let brandcategory = "brands/categories"
    static let brandcategoryfeed = "brands/posts-all"
    
    
    //Home Tab Bar
    
    //citizen top tab
    static let citizenRecents:String = "citizen/recents"
    
    static let likepost:String = "citizen/vote"
    static let citizenAddComment = "citizen/comment"
    static let citizenCommentList = "citizen/comments-thread"
    
    static let starCommentList = "star/comments-thread"
    static let starAddComment = "star/comment"
    
    //superstar
    static let starlikepost:String = "star/vote"
    
    
//    //Brand top tab
    static let brandlikePost = "brands/vote"
    static let brandDislikePost = "brands/vote"
    static let brandaddcomment = "brands/comment"
    static let brandCommentList = "brands/comments-thread"
    static let brandTitletap = "brands/category"
    
    // Ad section
    static let adData = "ads?type=h"
    
    // BookMark
    static let addBookmark = "bookmark"
    static let getbookmarks = "getbookmarks"
    static let unbookmark = "unbookmark"
    static let isbookmark = "isbookmark"
    
    //mark as spam
    static let addspam = "flag"
    
    
    //Category tab
    static let categoryTab = "news/category"
    
    
    //feeds post
    static let feedPost = "feed/post"
    static let singlefeedPost = "citizen/posts"
    //user profile
    static let Getprofile = "profile"
    static let updateProfile = "profile/update"
    static let updateProfilePic = "profile/update_pic"
    static let removeProfilePic = "profile/delete_pic"
    
    //Reward
    static let rewardgift = "reward/rewardgift"
    
    //Recommendation
    static let recomendationUrl:String = "star-suggest"
    static let followBrand:String = "profile/public/follow"
    static let unfollowBrand:String = "profile/public/unfollow"
}

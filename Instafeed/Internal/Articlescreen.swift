//
//  Articlescreen.swift
//  Instafeed
//
//  Created by gulam ali on 16/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit
import SDWebImage
import AVKit
import AVFoundation
import GPVideoPlayer
import FSPagerView
import SDWebImage

class Articlescreen: UIViewController, FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.imagearray.count
    }
    
    var userAvtar:String?
    
    @IBOutlet weak var heig_constraint: NSLayoutConstraint!
    @IBOutlet weak var addcomment_btn: UIButton!
    @IBOutlet weak var heightImgPost: NSLayoutConstraint!
    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var lblPost: UILabel!
    @IBOutlet weak var videoview: UIView!
    @IBOutlet weak var lblFollowers: UILabel!
    @IBOutlet weak var btnFollow: UIButton!
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var txtViewDescription: UITextView!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var lblCommentCount: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var HeightConstraint: NSLayoutConstraint!
    var feed = feedDatadata()
    var video =  [videosdata]()
    var imageOrg = String()
    var imagearray = [imageData]()
    var videoThumb = String()
    var dt_added = String()
   
    var postId = String()
    var moduleType = String()
    var videoPlayer: GPVideoPlayer?
    
    @IBOutlet weak var pageView: FSPagerView! {
        didSet {
            self.pageView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pageView.itemSize = FSPagerView.automaticSize
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        countLbl.isHidden = true
        self.imgProfilePic.layer.cornerRadius = self.imgProfilePic.layer.bounds.size.width / 2
        self.imgProfilePic.clipsToBounds = true
        
        if userAvtar != nil {
            let profileURL = URL(string: userAvtar ?? "")
            if profileURL != nil {
                print("Profile URL => \(profileURL!)")
             self.imgProfilePic.sd_setImage(with: profileURL!, placeholderImage: UIImage(named: "proo"), options: .preloadAllFrames, context: nil)
            }
        }
        tabBarController?.tabBar.isHidden = true
        
        pageView.delegate = self
        pageView.dataSource = self

        addcomment_btn.layer.cornerRadius = 20.0
        addcomment_btn.GetBorder(border: 1.0)
       
        videoPlayer = GPVideoPlayer.initialize(with: self.videoview.bounds)
            let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getNews(postId: self.postId)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        videoPlayer?.pauseVideo()
    }
    
    func setLayoutForView() {
        
        lblPost.text = moduleType == "3" ? self.feed.username : self.feed.first_name
        lblFollowers.text = self.feed.date
        lblTitle.text = self.feed.title
        lblDate.text = dt_added
        txtViewDescription.text = self.feed.description
        lblLikeCount.text = self.feed.total_likes ?? "0"
        lblCommentCount.text = self.feed.total_comments ?? "0"
        btnLike.setImage(UIImage(named: (self.feed.is_like == "0" || self.feed.is_like == nil) ? "heart" : "filledHeart"), for: .normal)
//        imgProfilePic.sd_setImage(with: URL(string: self.feed.avtar ?? ""), placeholderImage: UIImage(named: "proo"), options: .highPriority, completed: nil)
        imgPost.sd_setImage(with: URL(string: self.imageOrg as String ?? ""), placeholderImage: UIImage(named: "citizelcell"), options: .highPriority, completed: nil)
        lblTitle.text = self.feed.title ?? ""
        
        heightImgPost.constant = (moduleType == "3" ? 200 : 55)
        if moduleType == "3" {
            
            if self.feed.is_follow == "0" {
                
                btnFollow.setImage(UIImage(named: "Follow"), for: .normal)
            } else {
                
                btnFollow.setImage(UIImage(named: "Following"), for: .normal)
            }
        }

        if video.count > 0 {
            
            self.imgPost.sd_setImage(with: URL(string: videoThumb ), placeholderImage: UIImage(named: "citizelcell"), options: .highPriority, completed: nil)
            self.playVideo(videoURL: video[0].video ?? "")
        }
    }
    
    func getNews(postId: String) {
        
        
        var url = String()
        
           if moduleType == "1" {
               url = "citizen/posts"
           } else if moduleType == "2" {
               url = "star/posts"
           } else if moduleType == "3" {
               url = "brands/posts"
           } else if moduleType == "4" {
               url = "users/posts"
           } else {
               url = "brands/posts"
           }
        
        let apiurl = ServerURL.firstpoint + url
        let params = ["id":postId] as [String:Any]
       // let params = ["id":"604"] as [String:Any]
        networking.MakeRequest(Url: apiurl, Param: params, vc: self) { (response:feedDescription) in
            print(response)
            
            if response.message == "error"{
                Toast().showToast(message: "Something went wrong please try again later!!!", duration: 2)
                self.navigationController?.popViewController(animated: true)
            }else{
                if let data = response.data {
                    print(data as Any)
                    self.feed = data[0]
                    if data.count > 1 {
                        
                        self.video = (data[2].videos ?? nil)!
                        if data[2].videos?.count ?? 0 > 0 {
                            self.videoThumb = data[2].videos?[0].video_thumb ?? ""
                        }
                        
                    }
                    if data.count > 1 {
                        if let images = data[1].images {
                            if images != nil && images.isEmpty == false {
                                self.imagearray = images
                                self.imageOrg = images[0].image_264x200 ?? ""
                                self.pageView.reloadData()
                                self.countLbl.text = "\("1")/\(self.imagearray.count)"
                                self.countLbl.isHidden = false
                                self.heig_constraint.constant = 400
                            }else{
                               
                                self.heig_constraint.constant = 50
                            }
                        }
                        
                        if self.video.count > 0 {
                              self.heig_constraint.constant = 350
                        }
                    }

                    self.setLayoutForView()
                    self.isThisPostLiked()
                }
            }
        }
    }
        func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
            
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
            cell.imageView?.contentMode = .scaleAspectFill
            let strUrl = self.imagearray[index].image_264x200
                
            cell.imageView!.sd_setImage(with: URL(string: strUrl ?? ""), placeholderImage: UIImage(named: "citizelcell"), options: .highPriority, completed: nil)


            return cell
        }
        
        func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
            countLbl.text = "\(targetIndex + 1)/\(self.imagearray.count)"
    
    }

    private func playVideo(videoURL:String) {
        
///     This is by using third party way
        videoPlayer?.isToShowPlaybackControls = true
        self.videoview.addSubview(videoPlayer!)
        let videoUrls = URL(string: videoURL)!
        videoPlayer?.loadVideos(with: [videoUrls])
        videoPlayer?.isToShowPlaybackControls = true
        videoPlayer?.isMuted = false
        videoPlayer?.playVideo()
        
///     This is traditional native way
        
//       let videoUrls = NSURL(string: videoURL)
//       let player = AVPlayer(url: videoUrls! as URL)
//       let playerlayer = AVPlayerLayer(player: player)
//       playerlayer.frame = videoview.bounds
//       videoview.layer.addSublayer(playerlayer)
//       playerlayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
//       player.play()
        
    }
    
    @IBAction func btnFollowAction(_ sender: UIButton) {
        if moduleType == "3"{
            guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
            guard let userName = self.feed.username else{return}
            guard let id = self.feed.id else{return}
            CommonFuncs.addfollow(url: self.feed.is_follow == "0" ? ServerURL.addfollow :ServerURL.unfollow ,username: userName,vc: self, postid: id, token: UserToken, moduleId: self.moduleType, completionHandler: {resp, err in
                if resp?.message == "success"{
                    if self.feed.is_follow == "0"{
                        self.feed.is_follow = "1"
                        self.btnFollow.setImage(UIImage(named: "Following"), for: .normal)
                    }else{
                        self.feed.is_follow = "0"
                        self.btnFollow.setImage(UIImage(named: "Follow"), for: .normal)
                    }
                }
            })
        }
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnMoreAction(_ sender: UIButton) {
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if moduleType != "3"{
            let bookmark = UIAlertAction(title: "Block", style: .default) { action -> Void in
                self.blockTap()
            }
            //btnCamera.setValue(UIImage(named:"camera-icon"), forKey: "image")
            bookmark.setValue(UIColor(hexValue: InstafeedColors.ThemeOrange), forKey: "titleTextColor")
            actionSheetController.addAction(bookmark)
        }
        
        let More = UIAlertAction(title: "Report", style: .default) { action -> Void in
            self.spamActionSheet()
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
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    @IBAction func btnCommentAction(_ sender: UIButton) {
        let move = storyboard?.instantiateViewController(withIdentifier: "CommentVc") as! CommentVc
        if moduleType == "1"{
            move.TabType = "citizen"
        }else if moduleType == "3"{
            move.TabType = "brand"
        }else{
            move.TabType = "Star"
        }
        guard let id = feed.id else{return}
        move.postId = id
        navigationController?.pushViewController(move, animated: true)
    }
    
    func isThisPostLiked() {
        
        
        var url = String()
        
           if moduleType == "1" {
               url = "citizen/isvote"
           } else if moduleType == "2" {
               url = "star/isvote"
           } else if moduleType == "3" {
               url = "brands/isvote"
           } else if moduleType == "4" {
               url = "users/isvote"
           } else {
               url = "brands/isvote"
           }
        
        let apiurl = ServerURL.firstpoint + url
        guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
        let params = ["token":UserToken, "id":postId] as [String:Any]

        networking.MakeRequest(Url: apiurl, Param: params, vc: self) { (response:isPostLiked) in
            print(response)
            
            if response.status == 200 {
                
                if response.data?.message == "Already Up Vote marked" {
                    self.btnLike.setImage(UIImage(named: "filledHeart"), for: .normal)
                } else {
                    self.btnLike.setImage(UIImage(named: "heart"), for: .normal)
                }
            } else {
                
                self.btnLike.setImage(UIImage(named: "heart"), for: .normal)
            }
        }
    }
    
    @IBAction func btnLikeAction(_ sender: UIButton) {
        
        var url = String()
        if moduleType == "1" {
            
            url = ServerURL.likepost
        }else if moduleType == "2" {
            
            url = ServerURL.starlikepost
        }else{
            
            url = ServerURL.brandlikePost
        }
        
        let apiurl = ServerURL.firstpoint + url
        // let postId = Newsfeeds.id
        guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
        print("\(UserToken)")
        
        let params = ["token":UserToken, "id":postId, "vote": (self.feed.is_like == "0" || self.feed.is_like == nil) ?"u" : "d", "type":moduleType] as [String:Any]
        print(params)
        networking.MakeRequest(Url: apiurl, Param: params, vc: self) { (response:likePost) in
            print(response)
            
            if response.message == "error" {
                
                CommonFuncs.AlertWithOK(msg: Alertmsg.wentwrong, vc: self)
                return
            } else {
                
                if let totalLikesCount = self.feed.total_likes {
                    var totalLikes:Int = Int(totalLikesCount)!
                    totalLikes = totalLikes + 1
                    self.feed.total_likes = String(format: "%ld", totalLikes)
                    self.lblLikeCount.text = self.feed.total_likes ?? "0"
                    self.feed.is_like = (self.feed.is_like == "0" || self.feed.is_like == nil) ?  "1" : "0"
                    self.btnLike.setImage(UIImage(named: self.feed.is_like == "0" ? "heart" : "filledHeart"), for: .normal)
                }
            }
        }
    }
    
    @IBAction func btnShareAction(_ sender: UIButton) {
        let txt = """
        http://13.234.116.90/news/\(self.feed.slug ?? "")
        
        Download App for more updates
        www.google.com
        """
        
        // set up activity view controller
        let imageToShare = [ txt ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop ]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func spamActionSheet(){
        
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let bookmark = UIAlertAction(title:"Spam", style: .default) { action -> Void in
            self.spamTap(reasonId: "1") //reasonId = "1"
        }
        
        bookmark.setValue(UIColor(hexValue: InstafeedColors.ThemeOrange), forKey: "titleTextColor")
        actionSheetController.addAction(bookmark)
        
        let More = UIAlertAction(title: "Inappropriate", style: .default) { action -> Void in
            self.spamTap(reasonId: "2")//reasonId = "2"
        }
        
        More.setValue(UIColor(hexValue: InstafeedColors.ThemeOrange), forKey: "titleTextColor")
        actionSheetController.addAction(More)
        let speech = UIAlertAction(title: "Racism, Hate speech", style: .default) { action -> Void in
            self.spamTap(reasonId: "3")//reasonId = "3"
        }
        
        speech.setValue(UIColor(hexValue: InstafeedColors.ThemeOrange), forKey: "titleTextColor")
        actionSheetController.addAction(speech)
        
        let btnCancel = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        
        btnCancel.setValue(UIColor.red, forKey: "titleTextColor")
        actionSheetController.addAction(btnCancel)
        
        
        if let popoverController = actionSheetController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    func spamTap(reasonId:String) {
        print("spam tap citizen")
        guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
        guard let id = feed.id else {return}
        CommonFuncs.spammarked(url: ServerURL.addspam,vc: self, postid: id, token: UserToken, moduleId: "2", reasonId: reasonId, completionHandler: {resp, err in
            if resp?.message == "success"{
                self.spamSuccess()
            }
        })
    }
    
    func spamSuccess(){
        Toast().showToast(message: "Reported", duration: 2)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func blockTap() {
        
        // let postId = Newsfeeds.id
        guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
        print("\(UserToken)")
    
        guard let userName = self.feed.username else{return}
        
        let params = ["token":UserToken, "username":userName] as [String:Any]
        print(params)
        let apiurl = ServerURL.firstpoint + ServerURL.blockUser
        networking.MakeRequest(Url: apiurl, Param: params, vc: self) { (response:userBlocked) in
            print(response)
            
            if response.message == "error"{
                CommonFuncs.AlertWithOK(msg: Alertmsg.wentwrong, vc: self)
                return
            }else{
                if let data = response.data{
                    print(data as Any)
                    Toast().showToast(message: "Blocked", duration: 2)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
        
    }
}
struct feedDescription:Decodable {
    var message:String
    var data:[feedDatadata]?
    
}

struct isPostLiked: Decodable {
    
    var status:Int?
    var message:String?
    var data:likePostData?
}

struct likePostData: Decodable {
    
    var news_id: String?
    var user_id: String?
    var message: String?
    var vote_status: String?
}

struct feedDatadata: Decodable {
    var avtar:String?
    var id:String?
    var username:String?
    var news_category_id:String?
    var description:String?
    var title:String?
    var first_name:String?
    var is_follow:String?
    var is_like:String?
    var image:String?
    var images: [imageData]?
    var total_likes : String?
    var total_comments : String?
    var date: String?
    var slug:String?
    var videos: [videosdata]?
   
}
struct videosdata:Decodable {
    var id : String?
    var video_thumb:String?
    var video : String?
}

struct imageData: Decodable {
    var image_264x200 : String?
}

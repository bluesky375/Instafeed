//
//  FollowersAccountListViewController.swift
//  Instafeed
//
//  Created by A1GEISP7 on 11/09/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit
import SDWebImage

class FollowersAccountListViewController: UIViewController {

    @IBOutlet weak var lblFollowing: UILabel!
    @IBOutlet weak var lblFollowers: UILabel!
    @IBOutlet weak var lblFollowingSelected: UILabel!
    @IBOutlet weak var lblFollowersSelected: UILabel!
    @IBOutlet weak var btnFollowers: UIButton!
    @IBOutlet weak var btnFollowing: UIButton!
    @IBOutlet weak var tblFollowersList: UITableView!
    
    var orangeColor = UIColor.init(red: 241/255.0, green: 126/255.0, blue: 58/255.0, alpha: 1.0)
    let followersapiurl = "profile/followers"
    let followingapiurl = "profile/following"
    var followerUserList = [UserList]()
    var followingUserList = [UserList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBtnSelecting(isFollowerSelected: true)
        followerslist(url: followingapiurl)
        self.followerslist(url: self.followersapiurl)
    }
    
    @IBAction func btnFollowerAction(_ sender: UIButton) {
        
        followerslist(url: followersapiurl, isButtontapped: true)
    }
    
    @IBAction func btnFollowingAction(_ sender: UIButton) {
        
        followerslist(url: followingapiurl, isButtontapped: true)
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func setBtnSelecting(isFollowerSelected: Bool = false ){
        self.lblFollowers.textColor = isFollowerSelected ? .black : .lightGray
        self.lblFollowing.textColor = !isFollowerSelected ? .black : .lightGray
        
        self.btnFollowers.isSelected = isFollowerSelected
        self.btnFollowing.isSelected = !isFollowerSelected
        self.lblFollowersSelected.backgroundColor = self.btnFollowers.isSelected ? orangeColor : .clear
        self.lblFollowingSelected.backgroundColor = self.btnFollowers.isSelected ? .clear : orangeColor
        self.tblFollowersList.reloadData()
    }
    
    //list of followers
    func followerslist(url:String, isButtontapped:Bool = false) {
        let apiurl = ServerURL.firstpoint + url
        // let postId = Newsfeeds.id
        guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else { return }
        print("\(UserToken)")
        
        let params = ["token":UserToken] as [String:Any]
        print(params)
        
        networking.MakeRequest(Url: apiurl, Param: params, vc: self) { (response:FollowerModel) in
            print(response)
            
            if response.message == "error" {
                
                CommonFuncs.AlertWithOK(msg: Alertmsg.wentwrong, vc: self)
                return
            }else{
                
                if let resp = response.data {
                    if apiurl.contains(self.followersapiurl) {
                        
                        self.followerUserList = resp
                        self.setFollowersCount()
                        if isButtontapped {
                            self.setBtnSelecting(isFollowerSelected: true)
                        }
                        self.tblFollowersList.reloadData()
                    } else {
                        
                        self.followingUserList = resp
                        self.setFollowingCount()
                        if isButtontapped {
                            self.setBtnSelecting()
                        }
                        self.tblFollowersList.reloadData()
                    }
                }
            }
        }
    }
    
    func setFollowersCount(){
        if self.followerUserList.count == 0{
            self.lblFollowers.text = "FOLLOWER"
        } else if self.followerUserList.count >= 1000{
            let intNum = self.followerUserList.count / 1000
            let decimalNum:Double = Double(self.followerUserList.count % 1000)
            
            self.lblFollowers.text = String(format: "%ld.%.1f FOLLOWERS", intNum,decimalNum)
        } else{
            self.lblFollowers.text = String(format: "%ld FOLLOWERS", self.followerUserList.count)
        }
    }
    
    func setFollowingCount(){
        if self.followingUserList.count == 0{
            self.lblFollowing.text = "FOLLOWING"
        } else if self.followingUserList.count >= 1000{
            let intNum = self.followingUserList.count / 1000
            let decimalNum:Double = Double(self.followingUserList.count % 1000)
            
            self.lblFollowing.text = String(format: "%ld.%.1f FOLLOWINGS", intNum,decimalNum)
        } else{
            self.lblFollowing.text = String(format: "%ld FOLLOWINGS", self.followingUserList.count)
        }
    }
}
extension FollowersAccountListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.btnFollowing.isSelected{
            return self.followingUserList.count
        } else if self.btnFollowers.isSelected{
            return self.followerUserList.count
        } else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "contactcell") as? contactcell{
            cell.followDelegate = self
            if self.btnFollowers.isSelected {
                cell.btnFollow.isHidden = true
                cell.btnFollow.tag = (indexPath.row * 100) + 1
                if let username = self.followerUserList[indexPath.row].username{
                    cell.lblUsername.text = username
                } else{
                    cell.lblUsername.text = ""
                }
                if let name = self.followerUserList[indexPath.row].firstname{
                    cell.lblFullName.text = name
                } else{
                    cell.lblFullName.text = ""
                }
                
                if let profile = self.followerUserList[indexPath.row].avatar{
                    cell.imgProfilePic.sd_setImage(with: URL(string: profile), placeholderImage: UIImage(named: "proo"), options: .highPriority, context: nil)
                } else{
                    cell.imgProfilePic.image = UIImage(named: "proo")
                }
                
                if self.followerUserList[indexPath.row].is_follow == "0"{
                    cell.btnFollow.setImage(UIImage(named: "Follow"), for: .normal)
                } else{
                    cell.btnFollow.setImage(UIImage(named: "Following"), for: .normal)
                }
            } else {
                cell.btnFollow.isHidden = false
                cell.btnFollow.tag = (indexPath.row * 100) + 2
                cell.lblUsername.text = self.followingUserList[indexPath.row].username
                cell.lblFullName.text = self.followingUserList[indexPath.row].firstname
                if let profile = self.followingUserList[indexPath.row].avatar{
                    cell.imgProfilePic.sd_setImage(with: URL(string: profile), placeholderImage: UIImage(named: "proo"), options: .highPriority, context: nil)
                } else{
                    cell.imgProfilePic.image = UIImage(named: "proo")
                }
//                cell.btnFollow.setImage(UIImage(named: "Following"), for: .normal)
            }
            return cell
        } else{
            return UITableViewCell()
        }
    }
}
extension FollowersAccountListViewController: FollowButtonTapped{
    func followTapped(indexpath: Int) {
        let row = indexpath % 2 == 0 ? ((indexpath - 2) / 100) : ((indexpath - 1) / 100)
        if indexpath % 2 == 0{
            guard let username = self.followerUserList[row].username else{return}
            guard let isFollowing = self.followerUserList[row].is_follow else{return}
            self.FollowTap(username: username, isFollow: isFollowing == "0" ? "1" : "0", row: row)
            
        }else{
            guard let username = self.followingUserList[row].username else{return}
            self.FollowTap(username: username, isFollow: "0", row: row)
        }
        
    }
    
    
    func FollowTap(username: String, isFollow: String, row: Int) {
        
        // let postId = Newsfeeds.id
        guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
        print("\(UserToken)")
        
        let params = ["token":UserToken, "username":username] as [String:Any]
        print(params)
        if isFollow == "0"{
            let apiurl = ServerURL.firstpoint + ServerURL.followBrand
            networking.MakeRequest(Url: apiurl, Param: params, vc: self) { (response:barnddislikePost) in
                print(response)

                if response.message == "error"{
                    CommonFuncs.AlertWithOK(msg: Alertmsg.wentwrong, vc: self)
                    return
                }else{
                    if let data = response.data{
                        print(data as Any)
                        self.followerUserList.remove(at: row)
                        self.tblFollowersList.reloadData()
                        self.setFollowersCount()
                    }
                }
            }
        } else{
            let apiurl = ServerURL.firstpoint + ServerURL.unfollowBrand
            networking.MakeRequest(Url: apiurl, Param: params, vc: self) { (response:barnddislikePost) in
                print(response)
                
                if response.message == "error"{
                    CommonFuncs.AlertWithOK(msg: Alertmsg.wentwrong, vc: self)
                    return
                }else{
                    if let data = response.data{
                        print(data as Any)
                        self.followingUserList.remove(at: row)
                        self.tblFollowersList.reloadData()
                        self.setFollowingCount()
                    }
                }
            }
        }
        
    }
}

struct FollowerModel:Decodable{
    var message:String?
    var data:[UserList]?
}
struct UserList:Decodable {
    var id:String?
    var username:String?
    var firstname:String?
    var lastname:String?
    var avatar:String?
    var is_follow:String?
}

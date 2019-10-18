//
//  Brandcategories.swift
//  Instafeed
//
//  Created by gulam ali on 10/07/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit
import CarbonKit
import SDWebImage

class Brandcategories: UIViewController {
    
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var headtitle: UILabel!
    
    @IBOutlet weak var lblStoriesCount: UILabel!
    @IBOutlet weak var lblFollowersCount: UILabel!
    @IBOutlet weak var profilephoto: UIImageView!
    @IBOutlet weak var tabsView: UIView!
    @IBOutlet weak var tblView: UITableView!
    
    var orangeColor = UIColor.init(red: 241/255.0, green: 126/255.0, blue: 58/255.0, alpha: 1.0)
    var selectionCategoryIndex:Int = 0
    var BrandCategories = [profilecategoryData]()
    var profileResponse = profileData()
    var categoryFeedData = [categoryfeedData]()
    var TabNames = ["All Categories"]
    var username = String()
    var userId = String()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.register(UINib(nibName: "BrandCategoryFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "BrandCategoryFeedTableViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        navigationBarSetup()
        tabMenusetup()
        getProfile(userId: self.userId)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.selectionCategoryIndex = 0
    }
    
    //customise nav bar title.left bar item
    fileprivate func navigationBarSetup(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.title = ""
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "orangeback"), for: .normal)
        btn1.frame = CGRect(x: 15, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(tapSideMenu), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.leftBarButtonItem = item1
        
    }
    
    fileprivate func tabMenusetup(){
        getProfileCategories(userId: self.userId)
    }
    
    @objc func tapSideMenu(){
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK:>>>> Api call
    //for profile information
    func getProfile(userId: String) {
        print("single news")
        let apiurl = ServerURL.firstpoint + ServerURL.brandcategory
        let params = ["id":userId] as [String:Any]
        print(params)
        
        networking.MakeRequest(Url: apiurl, Param: params, vc: self) { (response:profile) in
            print(response)
            
            if response.message == "error"{
                CommonFuncs.AlertWithOK(msg: Alertmsg.wentwrong, vc: self)
                return
            }else{
                if let data = response.data{
                    print(data as Any)
                    self.profileResponse = data
                    
                    self.headtitle.text = "\(self.profileResponse.first_name) \(self.profileResponse.last_name)"
                    self.profilephoto.sd_setImage(with: URL(string: self.profileResponse.avatar ?? ""), placeholderImage: UIImage(named: "proo"), options: .highPriority, completed: nil)
                    
                    self.lblStoriesCount.text = "\(self.profileResponse.total_stories) Stories"
                    self.lblFollowersCount.text = "\(self.profileResponse.total_followers) Followers"
                }
            }
        }
        
    }
    
//    for profile categories
    func getProfileCategories(userId: String) {
        print("single news")
        let apiurl = ServerURL.firstpoint + ServerURL.brandcategory
        let params = ["id":userId] as [String:Any]
        print(params)
        
        networking.MakeRequest(Url: apiurl, Param: params, vc: self) { (response:profilecategory) in
            print(response)
            
            if response.message == "error"{
                CommonFuncs.AlertWithOK(msg: Alertmsg.wentwrong, vc: self)
                return
            }else{
                if let data = response.data{
                    print(data as Any)
                    self.BrandCategories = data
                    if self.BrandCategories.count > 0{
                        self.getProfileCategoriesfeed(userId: self.userId, categoryId: self.BrandCategories[0].category_id ?? "")
                        self.categoryCollectionView.reloadData()
                    }
                }
            }
        }
        
    }
    
    // get feed of the category
    func getProfileCategoriesfeed(userId: String, categoryId: String) {
        print("single news")
        let apiurl = ServerURL.firstpoint + ServerURL.brandcategoryfeed
        let langId = UserDefaults.standard.object(forKey: "languageId") as? String ?? "1"

        let params = ["id":userId, "lang_id":langId, "cat_id":categoryId, "start":0] as [String:Any]
        print(params)
        
        networking.MakeRequest(Url: apiurl, Param: params, vc: self) { (response:categoryfeed) in
            print(response)
            
            if response.message == "error"{
                CommonFuncs.AlertWithOK(msg: Alertmsg.wentwrong, vc: self)
                return
            }else{
                if let data = response.data{
                    print(data as Any)
                    self.categoryFeedData = data
                    self.tblView.reloadData()
                }
            }
        }
        
    }
    

}
extension Brandcategories: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell
        cell?.lblCategoryName.text = BrandCategories[indexPath.item].category_name
        cell?.imgSelection.backgroundColor = self.selectionCategoryIndex == indexPath.item ? orangeColor : .clear
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectionCategoryIndex = indexPath.item
        
        self.getProfileCategoriesfeed(userId: self.userId, categoryId: BrandCategories[indexPath.item].category_id ?? "")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let str:String = self.BrandCategories[indexPath.row].category_name ?? ""
        let width = UILabel.textWidth(font: UIFont.systemFont(ofSize: 14), text: str)
        return CGSize(width: width + 5 + 5, height: 55)
    }
}
extension UILabel {
    func textWidth() -> CGFloat {
        return UILabel.textWidth(label: self)
    }
    
    class func textWidth(label: UILabel) -> CGFloat {
        return textWidth(label: label, text: label.text!)
    }
    
    class func textWidth(label: UILabel, text: String) -> CGFloat {
        return textWidth(font: label.font, text: text)
    }
    
    class func textWidth(font: UIFont, text: String) -> CGFloat {
        let myText = text as NSString
        
        let rect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(labelSize.width)
    }
}
extension Brandcategories: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryFeedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BrandCategoryFeedTableViewCell") as? BrandCategoryFeedTableViewCell{
            cell.selectionStyle = .none
            cell.lblTitle.text = categoryFeedData[indexPath.row].title
            cell.lblDate.text = categoryFeedData[indexPath.row].date
            cell.imgPost.sd_setImage(with: URL(string: categoryFeedData[indexPath.row].image_360x290 ?? ""), placeholderImage: UIImage(named: "citizelcell"), options: .highPriority, completed: nil)
            return cell
        }else{
            return UITableViewCell()
        }
    }
}

/*extension Brandcategories: CarbonTabSwipeNavigationDelegate{
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        
        guard let storyboard = storyboard else { return UIViewController() }
        if index == 0 {
            return storyboard.instantiateViewController(withIdentifier: "allcategories")
        }else if index == 1{
            return storyboard.instantiateViewController(withIdentifier: "home")
        }else if index == 2{
            return storyboard.instantiateViewController(withIdentifier: "politics")
        }else if index == 3{
            return storyboard.instantiateViewController(withIdentifier: "entertainment")
        }else {
            return storyboard.instantiateViewController(withIdentifier: "world")
        }
        
    }
}*/
struct profile:Decodable {
    var message:String
    var data:profileData?
}
struct profilecategory:Decodable {
    var message:String
    var data :[profilecategoryData]?
}

struct profilecategoryData:Decodable {
 
    var category_id:String?
    var category_name:String?
    var description:String?
}

struct categoryfeed:Decodable {
    var message:String
    var data: [categoryfeedData]?
}

struct categoryfeedData:Decodable {
    
    var brand_category_id:String?
    var id:String?
    var short_description:String?
    var title:String?
    var image_360x290:String?
    var date:String
}

struct profileData:Decodable {
    var user_id:String?
    var username:String?
    var type:String?
    var type_name:String?
    var profile_url:String?
    var email:String?
    var avatar:String?
    var first_name:String?
    var last_name:String?
    var birth_date:String?
    var total_news_posts:String?
    var total_followers:String?
    var total_following:String?
    var total_stories:String?
    
    
}

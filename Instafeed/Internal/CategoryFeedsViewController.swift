//
//  CategoryFeedsViewController.swift
//  Instafeed
//
//  Created by A1GEISP7 on 14/09/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import UIKit

class CategoryFeedsViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblView: UITableView!
    
    var feedData = [categoryfeedData]()
    var categoryId = String()
    var categoryName = String()
    override func viewDidLoad() {
        super.viewDidLoad()
      self.tblView.register(UINib(nibName: "BrandCategoryFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "BrandCategoryFeedTableViewCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.lblTitle.text = categoryName
        self.getCategoriesfeed(categoryId: categoryId)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // get feed of the category
    func getCategoriesfeed(categoryId: String) {
        print("single news")
        let apiurl = ServerURL.firstpoint + ServerURL.brandcategoryfeed
        let langId = UserDefaults.standard.object(forKey: "languageId") as? String ?? "1"
        let params = ["lang_id": langId, "cat_id": categoryId, "start": 0] as [String:Any]
        print(params)
        
        networking.MakeGetRequest(Url: apiurl, Param: params, vc: self) { (response:feedData) in
            print(response)
            
            if response.message == "error" {
                CommonFuncs.AlertWithOK(msg: Alertmsg.wentwrong, vc: self)
                return
            } else {
                if let data = response.data {
                    print(data as Any)
                    self.feedData = data
                }
            }
        }
        
    }
}
extension CategoryFeedsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BrandCategoryFeedTableViewCell") as? BrandCategoryFeedTableViewCell{
            cell.selectionStyle = .none
            cell.lblTitle.text = feedData[indexPath.row].title
            cell.lblDate.text = feedData[indexPath.row].date
            cell.imgPost.sd_setImage(with: URL(string: feedData[indexPath.row].image_360x290 ?? ""), placeholderImage: UIImage(named: "citizelcell"), options: .highPriority, completed: nil)
            return cell
        }else{
            return UITableViewCell()
        }
    }
}

struct feedData:Decodable {
    var message:String
    var data:[categoryfeedData]?
}

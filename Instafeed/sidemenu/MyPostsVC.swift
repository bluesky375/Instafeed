//
//  MyPostsVC.swift
//  Instafeed
//
//  Created by Eric on 2019/10/16.
//  Copyright © 2019 backstage supporters. All rights reserved.
//

import UIKit
import Alamofire

class MyPostsVC: UIViewController {

    @IBOutlet weak var tblview: UITableView!
    var postList = [MyPostsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblview.delegate = self
        tblview.dataSource = self

        reloadTableView()
    }
    
    @IBAction func backFromMyPosts(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func editPost(sender: UIButton) {
        
    }
    
    @objc func deletePost(sender: UIButton) {
        let UserType = UserDefaults.standard.value(forKey: "UserType") as! Int
        if UserType > 2 {
            var apiMethod = "brand"
            if UserType == 4 {
                apiMethod = "citizen"
            } else if UserType == 5 {
                apiMethod = "star"
            }
            let url: String = "http://13.234.116.90/api/\(apiMethod)/post/delete"
            guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
            let params : Parameters = ["token": UserToken, "id": sender.tag]
            
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).validate().responseJSON{ response in
                switch response.result {
                case .success:
                    self.reloadTableView()
                case .failure(let error):
                    print("failed to load feeddata: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func reloadTableView() {
        print("Data => \(UserDefaults.standard.value(forKey: "UserType") ?? "Blank")")
        let UserType = Int(UserDefaults.standard.value(forKey: "UserType") as! String)
        if UserType! > 2 {
            var apiMethod = "brand"
            if UserType == 4 {
                apiMethod = "news"
            } else if UserType == 5 {
                apiMethod = "star"
            }
            let url: String = "http://13.234.116.90/api/profile/\(apiMethod)"
            guard let UserToken = UserDefaults.standard.value(forKey: "SavedToken") as? String else {return}
            let params : Parameters = ["token": UserToken]
            self.postList.removeAll()
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).validate().responseJSON{ response in
                switch response.result {
                case .success:
                    let json_data = response.result.value as! [String: Any]
                    let data = json_data["data"] as! [[String: Any]]
                    for entry in data {
                        let aResult = MyPostsModel(id: Int(entry["id"] as! String)!, url: entry["image"] as! String, title: entry["title"] as! String, date: entry["dt_modified"] as! String)
                        self.postList.append(aResult)
                    }
                    self.tblview.reloadData()
                case .failure(let error):
                    print("failed to load feeddata: \(error.localizedDescription)")
                }
            }
        }
    }
}

extension MyPostsVC : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyPostsCellID") as! MyPostsCell
        
        let imgUrl = URL(string: postList[indexPath.row].getUrl())
        let data = try? Data(contentsOf: imgUrl!)
        if let imageData = data {
            cell.postImage.image = UIImage(data: imageData)
        }
        cell.titleLabel.text = postList[indexPath.row].getTitle()
        cell.dateLabel.textColor = UIColor.lightGray
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateInFormat = dateFormatter.date(from: postList[indexPath.row].getDate())
        dateFormatter.dateFormat = "dd MMMM yyyy"
        cell.dateLabel.text = dateFormatter.string(from: dateInFormat!)
        cell.editButton.tag = postList[indexPath.row].getId()
        cell.delButton.tag = postList[indexPath.row].getId()
        cell.editButton.addTarget(self, action: #selector(editPost), for: .touchUpInside)
        cell.delButton.addTarget(self, action: #selector(deletePost), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

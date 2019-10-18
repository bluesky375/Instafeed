//
//  MyPostsModel.swift
//  Instafeed
//
//  Created by Eric on 2019/10/16.
//  Copyright © 2019 backstage supporters. All rights reserved.
//

import Foundation

class MyPostsModel {
    private var id: Int
    private var url: String
    private var title: String
    private var date: String
    
    init() {
        self.id = 0
        self.url = ""
        self.title = ""
        self.date = ""
    }
    
    init(id: Int, url: String, title: String, date: String) {
        self.id = id
        self.url = url
        self.title = title
        self.date = date
    }
    
    public func getId() -> Int {
        return id
    }
    
    public func getUrl() -> String {
        return url
    }
    
    public func getTitle() -> String {
        return title
    }
    
    public func getDate() -> String {
        return date
    }
}

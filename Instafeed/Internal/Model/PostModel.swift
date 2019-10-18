//
//  PostModel.swift
//  Instafeed
//
//  Created by eric on 2019/9/26.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import Foundation

class PostModel {
    private var url: String
    private var name: String
    private var postId: String
    
    init() {
        self.url = ""
        self.name = ""
        self.postId = ""
    }
    
    init(url: String, name: String, postId: String) {
        self.url = url
        self.name = name
        self.postId = postId
    }
    
    public func getUrl() -> String {
        return url
    }
    
    public func getName() -> String {
        return name
    }
    
    public func getID() -> String {
        return postId
    }
}


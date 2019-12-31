//
//  DataModel.swift
//  Assignment
//
//  Created by Prakash Sabale on 30/12/19.
//  Copyright © 2019 Orangebit. All rights reserved.
//

import Foundation

struct Response : Codable {
    
    struct DataContent : Codable {
        var title : String
        var excerpt : String
        var content : String
        var content_id : String
        var share_url : URL
        var langcode : String
        var type : String
        var created_on : String
        var created_by : String
        var post_id : String
        var category_id : String
        var category_name : String
        var tag_id : String
        var tag_name : String
        var rt_wp_rest_thumbnail : URL
        var video_url : URL
    }
    
    var data : [DataContent]
    var count : String
}

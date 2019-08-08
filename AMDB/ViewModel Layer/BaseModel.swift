//
//  BaseModel.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/6/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
//

import ObjectMapper

class BaseModel : Mappable {
    
    var status_code: Int?
    var status_message: String?
    var success: Bool?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        status_code <- map["status_code"]
        status_message <- map["status_message"]
        success <- map["success"]
    }
}

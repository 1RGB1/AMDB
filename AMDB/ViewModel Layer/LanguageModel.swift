//
//  LanguageModel.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/6/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
//

import ObjectMapper

class LanguageModel : Mappable {
    
    var iso_639_1: String?
    var name: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        iso_639_1 <- map["iso_639_1"]
        name <- map["name"]
    }
}

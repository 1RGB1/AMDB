//
//  CompaniesModel.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/6/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
//

import ObjectMapper

class CompaniesModel : Mappable {
    
    var id: Int?
    var logo_path: String?
    var name: String?
    var origin_country: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        logo_path <- map["logo_path"]
        name <- map["name"]
        origin_country <- map["origin_country"]
    }
}

//
//  CountriesViewModel.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/6/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
//

import ObjectMapper

class CountriesModel : Mappable {
    
    var iso_3166_1: String?
    var name: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        iso_3166_1 <- map["iso_3166_1:"]
        name <- map["name"]
    }
}

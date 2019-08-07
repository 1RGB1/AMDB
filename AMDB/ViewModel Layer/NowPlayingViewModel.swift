//
//  NowPlayingViewModel.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/6/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
//

import ObjectMapper

class NowPlayingModel : BaseViewModel {
    
    var page: Int?
    var results: [MovieModel]?
    var total_pages: Int?
    var total_results: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        page <- map["page"]
        results <- map["results"]
        total_pages <- map["total_pages"]
        total_results <- map["total_results"]
    }
}

//
//  ImageViewModel.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/6/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
//

import ObjectMapper

class ImageModel : Mappable {
    
    var aspect_ratio: Int?
    var file_path: String?
    var height: Int?
    var iso_639_1: String?
    var vote_average: Double?
    var vote_count: Int?
    var width: Int?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        aspect_ratio <- map["aspect_ratio"]
        file_path <- map["file_path"]
        height <- map["height"]
        iso_639_1 <- map["iso_639_1"]
        vote_average <- map["vote_average"]
        vote_count <- map["vote_count"]
        width <- map["width"]
    }
}

class ImagesModel : Mappable {
    
    var backdrops: [ImageModel]?
    var posters: [ImageModel]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        backdrops <- map["backdrops"]
    }
}

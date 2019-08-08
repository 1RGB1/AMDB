//
//  MovieModel.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/6/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
//

import ObjectMapper

class MovieModel: BaseModel {
    
    var adult: Bool?
    var backdrop_path: String?
    var belongs_to_collection: String?
    var budget: Double?
    var genres: [GenreModel]?
    var homepage: String?
    var id: Int?
    var imdb_id: String?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var production_companies: [CompanyModel]?
    var production_countries: [CountryModel]?
    var release_date: String?
    var revenue: Double?
    var runtime: Int?
    var spoken_languages: [LanguageModel]?
    var status: String?
    var tagline: String?
    var title: String?
    var video: Bool?
    var vote_average: Double?
    var vote_count: Int?
    var videos: VideosModel?
    var images: ImagesModel?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        adult <- map["adult"]
        backdrop_path <- map["backdrop_path"]
        belongs_to_collection <- map["belongs_to_collection"]
        budget <- map["budget"]
        genres <- map["genres"]
        homepage <- map["homepage"]
        id <- map["id"]
        imdb_id <- map["imdb_id"]
        original_language <- map["original_language"]
        original_title <- map["original_title"]
        overview <- map["overview"]
        popularity <- map["popularity"]
        poster_path <- map["poster_path"]
        production_companies <- map["production_companies"]
        production_countries <- map["production_countries"]
        release_date <- map["release_date"]
        revenue <- map["revenue"]
        runtime <- map["runtime"]
        spoken_languages <- map["spoken_languages"]
        status <- map["status"]
        tagline <- map["tagline"]
        title <- map["title"]
        video <- map["video"]
        vote_average <- map["vote_average"]
        vote_count <- map["vote_count"]
        videos <- map["videos"]
        images <- map["images"]
    }
    
    func getDuration() -> String {
        var result = ""
        
        if let duration = runtime {
            let hours: Int = Int(duration / 60)
            let minutes: Int = Int(duration % 60)
            
            if hours > 0 {
                result += "\(hours)"
                
                if minutes > 0 {
                    if minutes < 10 {
                        result += ":0\(minutes)"
                    } else {
                        result += ":\(minutes)"
                    }
                }
                
                result += " hours"
            } else {
                if minutes > 0 {
                    result += "\(minutes)"
                }
                
                result += " minutes"
            }
        }
        
        return result
    }
}

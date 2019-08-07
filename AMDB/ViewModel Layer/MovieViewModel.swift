//
//  MovieViewModel.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/6/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
//

import ObjectMapper

class MovieModel: BaseViewModel {
    
    var adult: Bool?
    var backdrop_path: String?
    var belongs_to_collection: String?
    var budget: Double?
    var genres: [GenresModel]?
    var homepage: String?
    var id: Int?
    var imdb_id: String?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var production_companies: [CompaniesModel]?
    var production_countries: [CountriesModel]?
    var release_date: Date?
    var revenue: Double?
    var runtime: Int?
    var spoken_languages: [LanguagesModel]?
    var status: String?
    var tagline: String?
    var title: String?
    var video: Bool?
    var vote_average: Double?
    var vote_count: Int?
    var videos: [VideosModel]?
    var images: [ImagesModel]?
    
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
}

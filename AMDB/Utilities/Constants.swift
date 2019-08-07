//
//  Constants.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/6/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
//

import Alamofire

// UI Manipulations
let SHADOW_GREY: CGFloat = 120 / 255.0

// HTPP Methods
let GET: HTTPMethod = HTTPMethod.get
let POST: HTTPMethod = HTTPMethod.post
let PUT: HTTPMethod = HTTPMethod.put

// API Key
let API_KEY: String = "4cbf3db237c47bdf6823456c12b9e569"

// Other URL Configurations
let APPENED_TO_RESPONSE: String = "&append_to_response="
let IMAGES: String = "images"
let VIDEOS: String = "videos"
let TIMEOUT: Double = 10.0
let ENGLISH: String = "en-US"

// Calling APIs
let BASE_URL: String = "https://api.themoviedb.org/3"
let IMAGE_BASE_URL: String = "https://image.tmdb.org/t/p/w500"
let NOW_PLAYING: String = BASE_URL + "/movie/now_playing"
let MOVIE: String = BASE_URL + "/movie/"

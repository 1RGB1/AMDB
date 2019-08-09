//
//  MoviesListPresenter.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/6/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
//
 
import ObjectMapper

class MovieStore : BaseNetwork {
    
    func getNowPlayingMoviesWithParameters(_ params: [String : AnyHashable], andCompletionHandler completion: @escaping (_ model: SearchMoviesModel?, _ error: String?) -> ()) {
        
        NetworkManager.performNetworkActivityWithURL(NOW_PLAYING, Parameters: params, HTTPMethod: GET) { (response) in
            
            if response.result.value == nil {
                completion(nil, self.handleError(999))
                return
            }
            
            let searchMoviesModel = Mapper<SearchMoviesModel>().map(JSONObject: response.result.value)
            completion(searchMoviesModel, searchMoviesModel?.status_message)
        }
    }
    
    func getMovieDetailsById(_ id: Int, withParameters params: [String : AnyHashable], andCompletionHandler completion: @escaping (_ model: MovieModel?, _ error: String?) -> ()) {
        
        NetworkManager.performNetworkActivityWithURL("\(MOVIE)\(id)", Parameters: params, HTTPMethod: GET) { (response) in
            
            if response.result.value == nil {
                completion(nil, self.handleError(999))
                return
            }
            
            let movieModel = Mapper<MovieModel>().map(JSONObject: response.result.value)
            completion(movieModel, movieModel?.status_message)
        }
    }
    
    func searchMovieWithParameters(_ params: [String : AnyHashable], andCompletionHandler completion: @escaping (_ model: SearchMoviesModel?, _ error: String?) -> ()) {
        
        NetworkManager.performNetworkActivityWithURL(SEARCH_MOVIE, Parameters: params, HTTPMethod: GET) { (response) in
            
            if response.result.value == nil {
                completion(nil, self.handleError(999))
                return
            }
            
            let searchMoviesModel = Mapper<SearchMoviesModel>().map(JSONObject: response.result.value)
            completion(searchMoviesModel, searchMoviesModel?.status_message)
        }
    }
}

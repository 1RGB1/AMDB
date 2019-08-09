//
//  MoviesListViewModel.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/6/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
//

import Foundation

protocol MoviesListViewModelDelegate {
    func setNowPlayingMoviesList(_ model: SearchMoviesModel?, _ error: String?)
    func setSearchMoviesList(_ model: SearchMoviesModel?, _ error: String?)
}

class MoviesListViewModel {
    
    // MARK: - Properties
    var movieStore = MovieStore()
    var delegate: MoviesListViewModelDelegate!
    
    // MARK: - Functions
    func getNowPlayingMoviesWithPage(_ page: Int) {
        
        let params: [String : AnyHashable] = ["api_key" : API_KEY,
                                              "language" : ENGLISH,
                                              "page" : page]
        
        movieStore.getNowPlayingMoviesWithParameters(params) { [weak self] (searchMoviesModel, error) in
            if error == nil {
                self?.delegate.setNowPlayingMoviesList(searchMoviesModel, nil)
            } else {
                self?.delegate.setNowPlayingMoviesList(nil, error)
            }
        }
    }
    
    func getMoviesBySearchWith(_ page: Int, andKeyword keyword: String) {
        
        let params: [String : AnyHashable] = ["api_key" : API_KEY,
                                              "language" : ENGLISH,
                                              "page" : page,
                                              "include_adult" : false,
                                              "query" : keyword]
        
        movieStore.searchMovieWithParameters(params) { [weak self] (searchMoviesModel, error) in
            if error == nil {
                self?.delegate.setSearchMoviesList(searchMoviesModel, nil)
            } else {
                self?.delegate.setSearchMoviesList(nil, error)
            }
        }
    }
}

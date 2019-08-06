//
//  MoviesListViewModel.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/6/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
//

import Foundation

protocol MoviesListViewModelDelegate {
    func setNowPlayingMoviesList(_ model: NowPlayingModel?)
}

class MoviesListViewModel {
    
    // MARK: - Properties
    var movieStore = MovieStore()
    var delegate: MoviesListViewModelDelegate!
    
    func getNowPlayingMoviesWithPage(_ page: Int) {
        
        let params: [String : AnyHashable] = ["api_key" : API_KEY,
                                              "language" : ENGLISH,
                                              "page" : page]
        
        movieStore.getNowPlayingMoviesWithParameters(params) { [weak self] (nowPlayingModel, error) in
            if error == nil {
                self?.delegate.setNowPlayingMoviesList(nowPlayingModel)
            } else {
                self?.delegate.setNowPlayingMoviesList(nil)
            }
        }
    }
}

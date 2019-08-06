//
//  MoviesListViewModel.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/6/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
//

import Foundation
import SVProgressHUD

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
        
        Utilities.showProgressHUD()
        
        movieStore.getNowPlayingMoviesWithParameters(params) { [weak self] (nowPlayingModel, error) in
            if error == nil {
                Utilities.showProgressHUDWithSuccess("Success")
                self?.delegate.setNowPlayingMoviesList(nowPlayingModel)
            } else {
                Utilities.showProgressHUDWithError(error ?? "")
                self?.delegate.setNowPlayingMoviesList(nil)
            }
        }
    }
}

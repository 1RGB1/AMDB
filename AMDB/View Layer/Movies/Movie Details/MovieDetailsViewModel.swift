//
//  MovieDetailsViewModel.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/7/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
//

import Foundation

protocol MovieDetailsViewModelDelegate {
    func setMovieMode(_ model: MovieModel?, _ error: String?)
}

class MovieDetailsViewModel {
    
    // MARK: - Properties
    var movieStore = MovieStore()
    var delegate: MovieDetailsViewModelDelegate!
    
    // MARK: - Functions
    func getMovieDetailsById(_ id: Int) {
        
        let params: [String : AnyHashable] = ["api_key" : API_KEY,
                                              "language" : ENGLISH,
                                              "append_to_response" : "videos,images"]
        
        movieStore.getMovieDetailsById(id, withParameters: params) { [weak self] (movieModel, error) in
            if error == nil {
                self?.delegate.setMovieMode(movieModel, nil)
            } else {
                self?.delegate.setMovieMode(nil, error)
            }
        }
    }
}

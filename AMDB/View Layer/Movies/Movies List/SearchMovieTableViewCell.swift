//
//  SearchMovieTableViewCell.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/8/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
//

import UIKit

class SearchMovieTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    // MARK: - Life Cycle Functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Functions
    func setCellModel(_ model: MovieModel) {
        Utilities.setImage(movieImageView, model.poster_path ?? "")
        movieTitleLabel.text = model.title ?? ""
    }
}

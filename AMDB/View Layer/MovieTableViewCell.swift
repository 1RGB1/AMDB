//
//  MovieTableViewCell.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/6/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var cellContentView: UIView!
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    // MARK: - Functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCellModel(_ model: MovieModel) {
        
    }
}

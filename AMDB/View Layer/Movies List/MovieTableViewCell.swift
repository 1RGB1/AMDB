//
//  MovieTableViewCell.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/6/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableViewCell : UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var cellContentView: UIView!
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    // MARK: - Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellContentView.setCornerByValue(cornerRadius: true, value: 40)
        cellContentView.addShadow(color: UIColor.black, opacity: 0.3, radius: 2)
    }
    
    func setCellModel(_ model: MovieModel) {
        setImage(model.backdrop_path ?? "")
        movieTitleLabel.text = model.title ?? ""
        movieDescriptionLabel.text = model.overview ?? ""
    }
    
    func setImage(_ imageURL: String) {
        let url = URL(string: IMAGE_BASE_URL + imageURL)
        movieImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "themoviedb"), options:[.transition(.fade(1))])
    }
}

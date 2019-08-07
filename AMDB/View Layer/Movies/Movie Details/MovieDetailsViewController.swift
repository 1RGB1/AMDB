//
//  MovieDetailsViewController.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/7/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
//

import UIKit

class MovieDetailsViewController : UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var companiesCollectionView: UICollectionView!
    @IBOutlet weak var movieDetailsStackView: UIStackView!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingProgressView: UIProgressView!
    
    @IBOutlet weak var companiesCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var companiesCollectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var ratingLabelLeadingConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var movieId: Int?
    var movie: MovieModel?
    var companies = [CompanyModel]()
    var movieDetailsViewModel = MovieDetailsViewModel()
    
    // MARK: - Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieDetailsViewModel.delegate = self
        ratingLabel.text = ""
        ratingProgressView.isHidden = true
        
        initCollectionView()
        getMovieDetails()
    }
    
    // MARK: - Functions
    func initCollectionView() {
        companiesCollectionView.delegate = self
        companiesCollectionView.dataSource = self
    }
    
    func getMovieDetails() {
        if let id = movieId {
            Utilities.showProgressHUD()
            movieDetailsViewModel.getMovieDetailsById(id)
        }
    }
    
    func fillData() {
        if let model = movie {
            
            if let model = movie {
                self.title = model.title ?? ""
                self.navigationController?.navigationBar.titleTextAttributes =
                    [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPS-BoldMT", size: 20)!]
            }
            
            Utilities.setImage(movieImageView, model.poster_path ?? "")
            
            if let overview = model.overview, overview != "" {
                movieOverviewLabel.text = overview
            } else {
                movieOverviewLabel.text = ""
            }
            
            if let companies = model.production_companies {
                if companies.count == 0 {
                    companiesCollectionViewHeightConstraint.constant = 0
                    companiesCollectionViewTopConstraint.constant = 0
                } else {
                    companiesCollectionViewHeightConstraint.constant = 100
                    companiesCollectionViewTopConstraint.constant = 15
                    companiesCollectionView.reloadData()
                }
            } else {
                companiesCollectionViewHeightConstraint.constant = 0
                companiesCollectionViewTopConstraint.constant = 0
            }
            
            if let budget = model.budget, budget != 0.0 {
                budgetLabel.text = "Budget: \(Int(budget)) $"
            } else {
                budgetLabel.text = "Budget: N/A"
            }
            
            if let revenue = model.revenue, revenue != 0.0 {
                revenueLabel.text = "Revenue: \(Int(revenue)) $"
            } else {
                revenueLabel.text = "Revenue: N/A"
            }
            
            if let date = model.release_date, date != "" {
                releaseDateLabel.text = "Released: " + date
            } else {
                releaseDateLabel.text = "Released: N/A"
            }
            
            if let _ = model.runtime, model.getDuration() != "" {
                durationLabel.text = "Duration: " + model.getDuration()
            } else {
                durationLabel.text = "Duration: N/A"
            }
            
            if let genres = model.genres, genres.count != 0 {
                genresLabel.text = "Genres: \(getGenresString(genres))"
            } else {
                genresLabel.text = "Genres: N/A"
            }
            
            if let rating = model.vote_average, rating != 0.0 {
                ratingLabel.text = "\(rating)/10"
                
                let ratio = Float(rating / 10.0)
                let maxWidth = Float(UIScreen.main.bounds.width - 30)
                ratingLabelLeadingConstraint.constant = CGFloat(maxWidth * ratio)
                
                ratingProgressView.setProgress(ratio, animated: true)
            } else {
                ratingLabel.text = "N/A"
                ratingProgressView.setProgress(0, animated: true)
            }
            
            ratingProgressView.isHidden = false
        }
    }
    
    func getGenresString(_ genres: [GenreModel]) -> String {
        var result = ""
        
        for idx in 0..<genres.count - 1 {
            if let name = genres[idx].name {
                result += name + ", "
            }
        }
        
        if let name = genres[genres.count - 1].name {
            result += name
        }
        
        return result
    }
}

// MARK: - Extensions
extension MovieDetailsViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return companies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = companiesCollectionView.dequeueReusableCell(withReuseIdentifier: "CompanyCollectionViewCell", for: indexPath) as! CompanyCollectionViewCell
        cell.setCellContent(companies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let cellCount = CGFloat(companies.count)
        
        if cellCount > 0 {
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let cellWidth = flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing
            
            let totalCellWidth = cellWidth * cellCount + 10.00 * (cellCount-1)
            let contentWidth = collectionView.frame.size.width - collectionView.contentInset.left - collectionView.contentInset.right
            
            if (totalCellWidth < contentWidth) {
                let padding = (contentWidth - totalCellWidth) / 2.0
                return UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
            } else {
                return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
            }
        }
        
        return UIEdgeInsets.zero
    }
}

extension MovieDetailsViewController : MovieDetailsViewModelDelegate {
    func setMovieMode(_ model: MovieModel?, _ error: String?) {
        if let movieModel = model {
            Utilities.showProgressHUDWithSuccess("Success")
            movie = movieModel
            
            if let productionCompanies = movieModel.production_companies {
                companies = productionCompanies
            }
            
            fillData()
        } else {
            Utilities.showProgressHUDWithError(error ?? "")
        }
    }
}

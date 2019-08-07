//
//  MoviesListViewController.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/6/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
//

import UIKit
import SVPullToRefreshImprove

class MoviesListViewController : UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var moviesListTableView: UITableView!
    
    // MARK: - Properties
    var movies = [MovieModel]()
    let movieListViewModel = MoviesListViewModel()
    var page = 1
    var maxPagesCount = 1
    var isFirstTimeLoad = true
    
    // MARK: - Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPS-BoldMT", size: 20)!]
        
        movieListViewModel.delegate = self
        
        initTableView()
        getNowPlayingMovies()
    }
    
    // MARK: - Functions
    func initTableView() {
        moviesListTableView.delegate = self
        moviesListTableView.dataSource = self
        moviesListTableView.addInfiniteScrolling { [weak self] in
            self?.getNowPlayingMovies()
        }
    }
    
    func getNowPlayingMovies() {
        
        if isFirstTimeLoad {
            Utilities.showProgressHUD()
        }
        
        movieListViewModel.getNowPlayingMoviesWithPage(page)
    }
}

// MARK: Extensions
extension MoviesListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieId = movies[indexPath.row].id
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let detailsViewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        
        detailsViewController.movieId = movieId
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesListTableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        cell.setCellModel(movies[indexPath.row])
        
        return cell
    }
}

extension MoviesListViewController : MoviesListViewModelDelegate {
    func setNowPlayingMoviesList(_ model: NowPlayingModel?, _ error: String?) {
        if let nowPlayingMovies = model, let newMovies = nowPlayingMovies.results, let allPages = nowPlayingMovies.total_pages {
            
            if isFirstTimeLoad {
                Utilities.showProgressHUDWithSuccess("Success")
                isFirstTimeLoad = false
            }
            
            moviesListTableView.infiniteScrollingView.stopAnimating()
            
            movies.append(contentsOf: newMovies)
            page += 1
            maxPagesCount = allPages
            
            moviesListTableView.reloadData()
            moviesListTableView.showsInfiniteScrolling = (page <= maxPagesCount)
        } else {
            if isFirstTimeLoad {
                Utilities.showProgressHUDWithError(error ?? "")
                isFirstTimeLoad = false
            }
            
            moviesListTableView.infiniteScrollingView.stopAnimating()
            moviesListTableView.showsInfiniteScrolling = false
        }
    }
}

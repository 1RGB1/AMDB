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
    @IBOutlet weak var searchMovieSearchBar: UISearchBar!
    @IBOutlet weak var moviesListTableView: UITableView!
    @IBOutlet weak var noDataFoundLabel: UILabel!
    
    // MARK: - Properties
    let movieListViewModel = MoviesListViewModel()
    
    var movies = [MovieModel]()
    var searchResult = [MovieModel]()
    var searchKeyword = ""
    
    var page = 1
    var searchPage = 1
    
    var maxPagesCount = 1
    var maxSearchPages = 1
    
    var isFirstTimeLoad = true
    var isInSearchMode = false
    
    // MARK: - Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPS-BoldMT", size: 20)!]
        
        movieListViewModel.delegate = self
        searchMovieSearchBar.delegate = self
        
        initTableView()
        getNowPlayingMovies()
    }
    
    // MARK: - Functions
    func initTableView() {
        moviesListTableView.delegate = self
        moviesListTableView.dataSource = self
        handleLoadMore()
    }
    
    func handleLoadMore() {
        moviesListTableView.addInfiniteScrolling { [weak self] in
            if (self?.isInSearchMode ?? false) {
                self?.getMoviesBySearch()
            } else {
                self?.getNowPlayingMovies()
            }
        }
    }
    
    func getNowPlayingMovies() {
        
        if isFirstTimeLoad {
            Utilities.showProgressHUD()
        }
        
        movieListViewModel.getNowPlayingMoviesWithPage(page)
    }
    
    func getMoviesBySearch() {
        movieListViewModel.getMoviesBySearchWith(searchPage, andKeyword: searchKeyword)
    }
}

// MARK: Extensions
extension MoviesListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = 0
        
        if isInSearchMode {
            count = searchResult.count
        } else {
            count = movies.count
        }
        
        if count == 0 {
            noDataFoundLabel.isHidden = false
            if !isFirstTimeLoad {
                noDataFoundLabel.text = "No Data Found"
            }
            moviesListTableView.isHidden = true
        } else {
            noDataFoundLabel.isHidden = true
            noDataFoundLabel.text = ""
            moviesListTableView.isHidden = false
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieId = (isInSearchMode) ? searchResult[indexPath.row].id : movies[indexPath.row].id
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let detailsViewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        
        detailsViewController.movieId = movieId
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isInSearchMode {
            let cell = moviesListTableView.dequeueReusableCell(withIdentifier: "SearchMovieTableViewCell", for: indexPath) as! SearchMovieTableViewCell
            cell.setCellModel(searchResult[indexPath.row])
            return cell
        } else {
            let cell = moviesListTableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
            cell.setCellModel(movies[indexPath.row])
            return cell
        }
    }
}

extension MoviesListViewController {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchMovieSearchBar.resignFirstResponder()
    }
}

extension MoviesListViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        handleLoadMore()
        searchResult.removeAll()
        searchPage = 1
        maxSearchPages = 1
        
        if searchText.count >= 4 {
            isInSearchMode = true
            searchKeyword = searchText
            movieListViewModel.getMoviesBySearchWith(searchPage, andKeyword: searchKeyword)
            moviesListTableView.separatorStyle = .singleLine
        } else {
            isInSearchMode = false
            moviesListTableView.separatorStyle = .none
            moviesListTableView.reloadData()
        }
    }
}

extension MoviesListViewController : MoviesListViewModelDelegate {
    func setNowPlayingMoviesList(_ model: SearchMoviesModel?, _ error: String?) {
        if let searchMoviesModel = model, let newMovies = searchMoviesModel.results, let allPages = searchMoviesModel.total_pages {
            
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
    
    func setSearchMoviesList(_ model: SearchMoviesModel?, _ error: String?) {
        if let searchMoviesModel = model, let newMovies = searchMoviesModel.results, let allPages = searchMoviesModel.total_pages {
            
            moviesListTableView.infiniteScrollingView.stopAnimating()
            
            searchResult.append(contentsOf: newMovies)
            searchPage += 1
            maxSearchPages = allPages
            
            moviesListTableView.reloadData()
            moviesListTableView.showsInfiniteScrolling = (searchPage <= maxSearchPages)
        } else {
            
            moviesListTableView.infiniteScrollingView.stopAnimating()
            moviesListTableView.showsInfiniteScrolling = false
        }
    }
}

//
//  MoviesListViewController.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/6/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var moviesListTableView: UITableView!
    
    // MARK: - Properties
    var movies = [MovieModel]()
    let movieListViewModel = MoviesListViewModel()
    var page = 1
    
    // MARK: - Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Now Playing"
        movieListViewModel.delegate = self
        
        initTableView()
        getNowPlayingMovies()
    }
    
    // MARK: - Functions
    func initTableView() {
        moviesListTableView.delegate = self
        moviesListTableView.dataSource = self
    }
    
    func getNowPlayingMovies() {
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
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesListTableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        cell.setCellModel(movies[indexPath.row])
        
        return cell
    }
}

extension MoviesListViewController : MoviesListViewModelDelegate {
    func setNowPlayingMoviesList(_ model: NowPlayingModel?) {
        if let nowPlayingMovies = model, let newMovies = nowPlayingMovies.results {
            movies.append(contentsOf: newMovies)
            page += 1
            moviesListTableView.reloadData()
        }
    }
}

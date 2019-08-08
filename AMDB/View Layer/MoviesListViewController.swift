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
    let moviesListPresenter = MoviesListPresenter()
    
    // MARK: - Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        getNowPlayingMovies()
    }
    
    // MARK: - Functions
    func initTableView() {
        moviesListTableView.delegate = self
        moviesListTableView.dataSource = self
    }
    
    func getNowPlayingMovies() {
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
        return UITableViewCell()
    }
}

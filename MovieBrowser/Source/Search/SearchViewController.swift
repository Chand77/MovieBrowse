//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    let network  = Network.shared
    var movieData = [MovieData]()
    var searchBarText = ""
    var duplicateData = [MovieData]()
    @IBOutlet weak var movieListTableView: UITableView!
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var searchButtonAction: UIButton!
    
    override func viewDidLoad() {
        movieListTableView.register(UINib(nibName: Constants.tableString, bundle: Bundle.main), forCellReuseIdentifier: Constants.movieString)
        movieListTableView.rowHeight = UITableView.automaticDimension;
        movieListTableView.estimatedRowHeight = 100.0;
        searchMovies(search: "1")
    }
//Movies searching
    func searchMovies(search: String) {
        network.fetchMoviesData(search: search) { (response) -> (Void) in
            self.movieData = response
            self.duplicateData = response
            DispatchQueue.main.async {
                self.movieListTableView.reloadData()
            }
        }
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        searchMovies(search: movieSearchBar.text ?? "")
                    }
}
// Table View Delegates
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
//Loading movies
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.movieString, for: indexPath) as! MovieTableViewCell
        cell.movieTitle.text = movieData[indexPath.row].title
        cell.releaseDate.text = Utilities().dateFormat(dateString: movieData[indexPath.row].release_date ?? "")
        cell.movieRating.text = String(movieData[indexPath.row].vote_average ?? 0.0)
        cell.layoutSubviews()
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: Constants.mainString, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: Constants.detailString) as! MovieDetailViewController
        newViewController.movieData = movieData[indexPath.row]
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
}
// Search View Delegates
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarText = searchText
        if searchBarText == "" {
            movieData = duplicateData
            movieListTableView.reloadData()
        }
        }
}

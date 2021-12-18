//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var movieLabelTitle: UILabel!
    @IBOutlet weak var releaseDateTitle: UILabel!
    @IBOutlet weak var pictureImage: UIImageView!
    @IBOutlet weak var pictureDescription: UILabel!
    
    let network  = Network.shared
    
    var movieData = MovieData()
    
    override func viewDidLoad() {
        movieLabelTitle.text = movieData.title
        releaseDateTitle.text = "Release Date: "+formatdate()
        pictureDescription.text = movieData.overview
        network.fetchImage(imagePath: movieData.poster_path ?? "") { (response) in
            print(response)
            DispatchQueue.main.async {
                self.pictureImage.image = response
            }
        }
    }
    
    func formatdate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let s = dateFormatter.date(from: movieData.release_date ?? "")
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter.string(from: s!)
    }
}

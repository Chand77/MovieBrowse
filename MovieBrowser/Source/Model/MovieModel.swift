//
//  MovieModel.swift
//  MovieBrowser
//
//  Created by Chand on 12/17/2021.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation
struct MovieData: Codable {
    var title: String? = ""
    var release_date: String? = ""
    var vote_average: Double? = 0.0
    var poster_path: String? = ""
    var overview: String? = ""
}

struct MovieDataResults: Codable {
    var results: [MovieData]
}

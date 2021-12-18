//
//  Network.swift
//  SampleApp
//
//  Created by Struzinski, Mark - Mark on 9/17/20.
//  Copyright © 2020 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class Network {
    static let shared = Network()
    private init(){}
    let apiKey = "5885c445eab51c7004916b9c0313e2d3"
    
    func fetchMoviesData(search: String,
                         onCompletion : @escaping ([MovieData]) -> Void) {
        //let searchKey = search.replacingOccurrences(of: "", with: "%20")
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(search)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
                   return
               }
        var request = URLRequest(url: url)
               request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil {
                let decoder = JSONDecoder()
                if let responseData = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments)
                        print(json)
                        let decodedData = try decoder.decode(MovieDataResults.self, from: responseData)
                        onCompletion(decodedData.results)
                    } catch {
                        print(error)
                    }
                }
            } else {
            }
             }
             task.resume()
         }
    
    
    func fetchImage(imagePath: String, onCompletion : @escaping (UIImage) -> Void) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(imagePath)") else {
                   return
               }
        var request = URLRequest(url: url)
               request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if let responseData = data {
                let image = UIImage(data:responseData,scale:1.0)
                    onCompletion(image!)
                }
            } else {
            }
             }
             task.resume()
         }
    
    }

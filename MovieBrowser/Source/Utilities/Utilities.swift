//
//  Utilities.swift
//  MovieBrowser
//
//  Created by Chand on 12/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation
struct Utilities{
// String to date conversion
    func dateFormat(dateString: String) -> String {
        let dateFormatter = dateFormatFromServer()
        let s = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter.string(from: s!)
    }
    
    func formatDate(dateString: String) -> String {
        let dateFormatter = dateFormatFromServer()
        let s = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter.string(from: s!)
        }
    
    func dateFormatFromServer() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormatFromServer
        return dateFormatter
    }
}



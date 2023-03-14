//
//  SearchResponse.swift
//  IMDb REST API
//
//  Created by Антон Пеньков on 13.03.2023.
//

import Foundation

struct SearchResponse: Decodable {
    var searchType: String
    var results: [Movie]
}

struct Movie: Decodable {
    var image: String
    var title: String
    var description: String
}

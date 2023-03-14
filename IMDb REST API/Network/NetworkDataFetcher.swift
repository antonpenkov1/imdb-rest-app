//
//  NetworkDataFetcher.swift
//  IMDb REST API
//
//  Created by Антон Пеньков on 13.03.2023.
//

import Foundation
import UIKit

class NetworkDataFetcher {
    
    let networkService = NetworkService()
    
    func fetchTitles(urlString: String, response: @escaping (SearchResponse?) -> Void) {
        networkService.request(urlString: urlString) { (result) in
            switch result {
                
            case .success(let data):
                do {
                    let movieTitles = try JSONDecoder().decode(SearchResponse.self, from: data)
                    response(movieTitles)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
}

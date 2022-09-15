//
//  Constants.swift
//  NewsApp
//
//  Created by detaysoft on 15.09.2022.
//

import Foundation

struct Constants {
    struct ProductionServer {
        static let baseURL = "http://newsapi.org/v2/top-headlines?country=tr&"

    }
    
    struct APIParameterKey {
        static let countryCode = "country_code"
        static let randomCode = "random_code"
        static let cPassword = "c_password"
        static let apiKey = "d4b26469d3af47b19e0bc5228465fc0e"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}

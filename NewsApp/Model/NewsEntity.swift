//
//  NewsEntity.swift
//  NewsApp
//
//  Created by detaysoft on 12.09.2022.
//

import Foundation

// MARK: - News
struct News: Codable {
    let success: Bool
    let result: [Result]
}

// MARK: - Result
struct Result: Codable {
    let key: String
    let url: String
    let resultDescription: String
    let image: String
    let name, source, date: String
    
    enum CodingKeys: String, CodingKey {
        case key, url
        case resultDescription = "description"
        case image, name, source, date
    }
}

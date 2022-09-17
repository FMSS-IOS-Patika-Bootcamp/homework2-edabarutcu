//
//  NewsEntity.swift
//  NewsApp
//
//  Created by detaysoft on 12.09.2022.
//

import Foundation

struct News : Decodable {
    let news : [NewsDetail]
}

struct NewsDetail : Decodable {
    let category : String?
    let title : String?
    let spot : String?
    let imageUrl : String?
    let videoUrl : String?
    let webUrl : String?
}


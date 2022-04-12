//
//  MovieListDto.swift
//  ANCHOREER
//
//  Created by 표건욱 on 2022/04/10.
//

import Foundation

struct MovieListDto: Codable {
    struct Request: Codable {
        
    }
    
    struct Response: Codable {
        let lastBuildDate: Date?
        let total: Int
        let start: Int
        let display: Int
        let items: [Item]
        
        struct Item: Codable, Equatable {
            let title: String
            let link: String
            let image: String?
            let subtitle: String
            let pubDate: String
            let director: String
            let actor: String
            let userRating: String
        }
    }
}

struct ErrorModel: Codable {
    let errorMessage: String // "Not Exist Client ID : Authentication failed. (인증에 실패했습니다.)",
    let errorCode: String // "024"
}

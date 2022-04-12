//
//  MovieListAPI.swift
//  ANCHOREER
//
//  Created by 표건욱 on 2022/04/10.
//

import Foundation
import Alamofire
import RxSwift


enum MovieListAPI: APIType {
    case getSearchMovie(query: String)
    
    var path: String {
        switch self {
        case .getSearchMovie:
            return "https://openapi.naver.com/v1/search/movie.json"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getSearchMovie:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .getSearchMovie:
            return [NaverHeader.id: NaverHeaderValue.id,
                    NaverHeader.secret: NaverHeaderValue.secret]
        }
    }
    
    var parameter: Parameters? {
        switch self {
        case .getSearchMovie(let query):
            return ["query": query]
        }
    }
}

//
//  AnchoreerDecoder.swift
//  ANCHOREER
//
//  Created by 표건욱 on 2022/04/10.
//

import Foundation

class AnchoreerDecoder: JSONDecoder {
    
    static let dateFormat = "E, dd MMM yyyy HH:mm:ss z"
    
    override init() {
        super.init()

        self.keyDecodingStrategy = .convertFromSnakeCase

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = AnchoreerDecoder.dateFormat
        self.dateDecodingStrategy = .formatted(dateFormatter)
    }
}

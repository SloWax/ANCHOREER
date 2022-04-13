//
//  Extension+String.swift
//  ANCHOREER
//
//  Created by 표건욱 on 2022/04/10.
//

import Foundation

extension String {
    func filterString(of: [String]) -> String {
        var current = self
        
        of.forEach { of in
            current = current.replacingOccurrences(of: of, with: "")
        }
        
        return current
    }
    
    func replace(of: String, with: String = "") -> String {
        return self.replacingOccurrences(of: of, with: with)
    }
}

//
//  BaseVM.swift
//  ANCHOREER
//
//  Created by 표건욱 on 2022/04/10.
//

import Foundation
import RxSwift
import RxCocoa

class BaseVM {
    deinit {
        print("<<<<<< END \(Self.self) >>>>>>")
    }
    
    var bag = DisposeBag()
    
    func task<T: Codable>(_ type: T.Type, data: Data?, success: (T) -> Void) {
        do {
            if let data = data {
                let parsing = try AnchoreerDecoder().decode(T.self, from: data)
                success(parsing)
            }
        } catch {
            print("error: \(error)")
        }
    }
    
    func clearBag() {
        self.bag = DisposeBag()
    }
}

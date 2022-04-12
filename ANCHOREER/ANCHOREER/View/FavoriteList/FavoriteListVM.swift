//
//  FavoriteListVM.swift
//  ANCHOREER
//
//  Created by 표건욱 on 2022/04/11.
//


import Foundation
import RxSwift
import RxCocoa


class FavoriteListVM: BaseVM {
    struct Output {
        let list = BehaviorRelay<[MovieListDto.Response.Item]>(value: [])
    }
    
    let output: Output
    
    init(output: Output = Output()) {
        self.output = output
        super.init()
        
        let favoriteList = FavoriteManager.shared.retrieve()
        self.output.list.accept(favoriteList)
    }
}

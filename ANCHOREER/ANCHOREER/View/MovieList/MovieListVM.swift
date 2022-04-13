//
//  MovieListVM.swift
//  ANCHOREER
//
//  Created by 표건욱 on 2022/04/09.
//


import Foundation
import RxSwift
import RxCocoa


class MovieListVM: BaseVM {
    struct Input {
        let keyword = BehaviorRelay<String>(value: "") // 검색 키워드
    }
    
    struct Output {
        let list = BehaviorRelay<[MovieListDto.Response.Item]>(value: []) // 검색 결과 리스트
    }
    
    let input: Input
    let output: Output
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        super.init()
    }
    
    func searchMovie() {
        let keyword = input.keyword.value
        guard !keyword.isEmpty else { return }
        
        APIService
            .shared
            .request(api: MovieListAPI.getSearchMovie(query: keyword))
            .subscribe { [weak self] data in
                guard let self = self else { return }
                
                self.task(MovieListDto.Response.self, data: data) { res in
                    self.output.list.accept(res.items)
                }
            } onError: { error in
                print("error: \(error)")
            }.disposed(by: bag)
    }
}

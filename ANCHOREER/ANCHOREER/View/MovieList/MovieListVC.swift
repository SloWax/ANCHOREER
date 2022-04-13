//
//  MovieListVC.swift
//  ANCHOREER
//
//  Created by 표건욱 on 2022/04/09.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import RxOptional


class MovieListVC: BaseVC {
    
    private let movieListView = MovieListView()
    private var vm: MovieListVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 화면 전환 시 보여지고 있는 리스트 즐겨찾기 refresh
        self.vm.searchMovie()
    }
    
    override func rightMenu() {
        let rootVC = FavoriteListVC()
        let navi = UINavigationController(rootViewController: rootVC)
        
        presentVC(navi)
    }
    
    private func setInputs() -> MovieListVM {
        return MovieListVM()
    }
    
    private func initialize() {
        setLeftTitle("네이버 영화 검색")
        setRightFavorite()
        
        view = movieListView
        
        movieListView.tvList.register(MovieListCell.self, forCellReuseIdentifier: MovieListCell.id)
        
        vm = setInputs()
    }
    
    private func bind() {
        movieListView.tfSearch // 검색 keyword
            .rx
            .text
            .orEmpty
            .bind(to: self.vm.input.keyword)
            .disposed(by: bag)
        
        movieListView.tfSearch // 영화 검색 시점
            .rx
            .controlEvent(.editingDidEnd)
            .bind { [weak self] in
                guard let self = self else { return }
                
                self.vm.searchMovie()
            }.disposed(by: bag)
        
        movieListView.tvList // cell 선택 시 화면 전환
            .rx
            .itemSelected
            .bind { [weak self] indexPath in
                guard let self = self else { return }
                
                let item = self.vm.output.list.value[indexPath.row]
                let vc = MovieDetailVC(item: item)
                let title = item.title.filterString(of: ["<b>", "</b>"])
                
                self.pushVC(vc, title: title)
            }.disposed(by: bag)
        
        vm.output // 영화 리스트 tableView
            .list
            .bind(to: movieListView.tvList
                .rx
                .items(cellIdentifier: MovieListCell.id,
                       cellType: MovieListCell.self)
            ) { row, data, cell in
                
                /**
                 DB에 있는 리스트를 가져와 현재 표현하는 영화가 즐겨찾기 되어있는 객체인지 확인
                 검색 키워드에 따라 title이 다른 response 받아 같은 영화여도 다른 영화로 확인
                 객체 id가 없어 link 로 대체하여 즐겨찾기 된 객체인지 확인
                 **/
                let favoriteList = FavoriteManager.shared.retrieve()
                let isFavorite = favoriteList.contains { $0.link == data.link }
                
                cell.setValue(data, isFavorite: isFavorite)
                
                cell.btnStar // cell 내 즐겨찾기 button
                    .rx
                    .tap
                    .bind {
                        cell.updateFavorite(data)
                    }.disposed(by: cell.bag)
            }.disposed(by: bag)
    }
}

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
        movieListView.tfSearch
            .rx
            .text
            .orEmpty
            .bind(to: self.vm.input.keyword)
            .disposed(by: bag)
        
        movieListView.tfSearch
            .rx
            .controlEvent(.editingDidEnd)
            .bind { [weak self] in
                guard let self = self else { return }
                
                self.vm.searchMovie()
            }.disposed(by: bag)
        
        movieListView.tvList
            .rx
            .itemSelected
            .bind { [weak self] indexPath in
                guard let self = self else { return }
                
                let item = self.vm.output.list.value[indexPath.row]
                let vc = MovieDetailVC(item: item)
                let title = item.title.filterString(of: ["<b>", "</b>"])
                
                self.pushVC(vc, title: title)
            }.disposed(by: bag)
        
        vm.output
            .list
            .bind(to: movieListView.tvList
                .rx
                .items(cellIdentifier: MovieListCell.id,
                       cellType: MovieListCell.self)
            ) { row, data, cell in
                let favoriteList = FavoriteManager.shared.retrieve()
                let isFavorite = favoriteList.contains { $0.link == data.link }
                
                cell.setValue(data, isFavorite: isFavorite)
                
                cell.btnStar
                    .rx
                    .tap
                    .bind {
                        cell.updateFavorite(data)
                    }.disposed(by: cell.bag)
            }.disposed(by: bag)
    }
}

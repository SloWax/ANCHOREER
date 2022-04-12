//
//  FavoriteListVC.swift
//  ANCHOREER
//
//  Created by 표건욱 on 2022/04/11.
//


import UIKit
import RxSwift
import RxCocoa
import RxOptional


class FavoriteListVC: BaseVC {
    private let favoriteListView = FavoriteListView()
    private var vm: FavoriteListVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        bind()
    }
    
    override func leftMenu() {
        clearBag(vm: vm)
        dismiss(animated: true)
    }
    
    private func setInputs() -> FavoriteListVM {
        return FavoriteListVM()
    }
    
    private func initialize() {
        setNavigationTitle(title: "즐겨찾기 목록")
        setLeftDismiss()
        
        view = favoriteListView
        
        favoriteListView.tvList.register(MovieListCell.self, forCellReuseIdentifier: MovieListCell.id)
        
        vm = setInputs()
    }
    
    private func bind() {
        vm.output
            .list
            .bind(to: favoriteListView.tvList
                .rx
                .items(cellIdentifier: MovieListCell.id,
                       cellType: MovieListCell.self)
            ) { row, data, cell in
                let favoriteList = FavoriteManager.shared.retrieve()
                let isFavorite = favoriteList.contains { $0 == data }
                
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

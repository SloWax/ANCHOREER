//
//  FavoriteListVC.swift
//  ANCHOREER
//
//  Created by 표건욱 on 2022/04/11.
//


import UIKit
import RxSwift
import RxCocoa


class FavoriteListVC: BaseVC {
    private let favoriteListView = FavoriteListView()
    private var vm: FavoriteListVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 화면 전환 시 보여지고 있는 리스트 즐겨찾기 불러오기
        let favoriteList = FavoriteManager.shared.retrieve()
        self.vm.output.list.accept(favoriteList)
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
        favoriteListView.tvList // cell 선택 시 화면 전환
            .rx
            .itemSelected
            .bind { [weak self] indexPath in
                guard let self = self else { return }
                
                let item = self.vm.output.list.value[indexPath.row]
                let vc = MovieDetailVC(item: item)
                let title = item.title.filterString(of: ["<b>", "</b>"])
                
                self.pushVC(vc, title: title)
            }.disposed(by: bag)
        
        vm.output // 즐겨찾기 한 영화 목록
            .list
            .bind(to: favoriteListView.tvList
                .rx
                .items(cellIdentifier: MovieListCell.id,
                       cellType: MovieListCell.self)
            ) { row, data, cell in
                cell.setValue(data, isFavorite: true)
                
                cell.btnStar // cell 내 즐겨찾기 button
                    .rx
                    .tap
                    .bind {
                        cell.updateFavorite(data)
                    }.disposed(by: cell.bag)
            }.disposed(by: bag)
    }
}

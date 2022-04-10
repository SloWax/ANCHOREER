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
        
    }
}

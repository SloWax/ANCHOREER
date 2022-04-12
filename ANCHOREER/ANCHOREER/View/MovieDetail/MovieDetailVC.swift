//
//  MovieDetailVC.swift
//  ANCHOREER
//
//  Created by 표건욱 on 2022/04/11.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional
import WebKit


class MovieDetailVC: BaseVC, WKUIDelegate, WKNavigationDelegate {
    
    private let item: MovieListDto.Response.Item
    
    private let movieDetailView = MovieDetailView()
    
    private var isFavorite = false
    
    init(item: MovieListDto.Response.Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        bind()
    }
    
    private func initialize() {
        view = movieDetailView
        
        let favoriteList = FavoriteManager.shared.retrieve()
        let isFavorite = favoriteList.contains { $0.link == item.link }
        
        self.isFavorite = isFavorite
        movieDetailView.setValue(item, isFavorite: isFavorite)
        
        guard let url = URL(string: item.link) else { return }
        print("url: \(url)")
        
        let request = URLRequest(url: url)
        movieDetailView.wvView.load(request)
    }
    
    private func bind() {
        movieDetailView.btnStar
            .rx
            .tap
            .bind { [weak self] in
                guard let self = self else { return }
                
                self.isFavorite ?
                FavoriteManager.shared.delete(self.item) :
                FavoriteManager.shared.create(self.item)
                
                self.isFavorite = !self.isFavorite
                self.movieDetailView.btnStar.tintColor = self.isFavorite ? .yellow : .lightGray
            }.disposed(by: bag)
    }
}

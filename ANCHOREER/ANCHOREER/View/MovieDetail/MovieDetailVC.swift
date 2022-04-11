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
    }
    
    private func initialize() {
        view = movieDetailView
        movieDetailView.setValue(item)
        
        guard let url = URL(string: item.link) else { return }
        print("url: \(url)")
        
        let request = URLRequest(url: url)
        movieDetailView.wvView.load(request)
    }
}

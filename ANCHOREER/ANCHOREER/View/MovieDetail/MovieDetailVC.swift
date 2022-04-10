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


class MovieDetailVC: BaseVC {
    private let url: URL
    
    private let movieDetailView = MovieDetailView()
    
    init(url: URL) {
        self.url = url
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
        
        let request = URLRequest(url: url)
        movieDetailView.wvView.load(request)
    }
    
    private func bind() {
        
    }
}

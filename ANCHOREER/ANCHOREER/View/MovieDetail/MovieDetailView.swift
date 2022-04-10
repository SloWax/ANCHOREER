//
//  MovieDetailView.swift
//  ANCHOREER
//
//  Created by 표건욱 on 2022/04/11.
//


import UIKit
import SnapKit
import Then
import WebKit


class MovieDetailView: BaseView {
    
    let wvView = WKWebView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUP()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUP() {
        addSubview(wvView)
    }
    
    private func setLayout() {
        wvView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

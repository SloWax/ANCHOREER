//
//  MovieListView.swift
//  ANCHOREER
//
//  Created by 표건욱 on 2022/04/09.
//


import UIKit
import SnapKit
import Then


class MovieListView: BaseView {
    
    let tfSearch = UITextField().then {
        $0.clearButtonMode = .always
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.lightGray.cgColor
        
        let frame = CGRect(x: 0, y: 0, width: 10, height: 0)
        let paddingView = UIView(frame: frame)
        $0.leftView = paddingView
        $0.leftViewMode = .always
    }
    let tvList = UITableView().then {
        $0.keyboardDismissMode = .onDrag
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUP()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tfSearch.layer.cornerRadius = tfSearch.frame.width * 0.025
    }
    
    private func setUP() {
        self.addSubviews([tfSearch, tvList])
    }
    
    private func setLayout() {
        tfSearch.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(tfSearch.snp.width).multipliedBy(0.1)
        }
        
        tvList.snp.makeConstraints { make in
            make.top.equalTo(tfSearch.snp.bottom).offset(10)
            make.left.right.equalTo(tfSearch)
            make.bottom.equalToSuperview()
        }
    }
}

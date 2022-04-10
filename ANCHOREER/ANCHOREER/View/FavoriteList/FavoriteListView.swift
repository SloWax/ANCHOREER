//
//  FavoriteListView.swift
//  ANCHOREER
//
//  Created by 표건욱 on 2022/04/11.
//


import UIKit
import SnapKit
import Then


class FavoriteListView: BaseView {
    
    let tvList = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUP()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUP() {
        addSubview(tvList)
    }
    
    private func setLayout() {
        tvList.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
}

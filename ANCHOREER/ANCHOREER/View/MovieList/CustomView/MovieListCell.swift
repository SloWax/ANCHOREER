//
//  MovieListCell.swift
//  ANCHOREER
//
//  Created by 표건욱 on 2022/04/09.
//

import UIKit
import SnapKit
import Then
import Kingfisher
import RxSwift

class MovieListCell: UITableViewCell {
    
    static let id = "MovieListCell"
    
    var bag = DisposeBag()
    
    private let ivImage = UIImageView()
    
    private let lblTitle = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 18)
    }
    
    private let lblDirector = UILabel()
    
    private let lblActor = UILabel()
    
    private let lblGrade = UILabel()
    
    let btnStar = UIButton().then {
        let image = UIImage(systemName: "star.fill")
        $0.setImage(image, for: .normal)
        $0.tintColor = .lightGray
    }
    
    private let viewDivider = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUP()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        bag = DisposeBag()
        btnStar.tintColor = .lightGray
    }
    
    private func setUP() {
        self.selectionStyle = .none
        
        let views = [ivImage, lblTitle, lblDirector,
                     lblActor, lblGrade, btnStar, viewDivider]
        
        self.contentView.addSubviews(views)
    }
    
    private func setLayout() {
        ivImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.225)
            make.height.equalTo(ivImage.snp.width).multipliedBy(1.3)
        }
        
        btnStar.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.1)
            make.height.equalTo(btnStar.snp.width)
        }
        
        lblTitle.snp.makeConstraints { make in
            make.top.equalTo(ivImage)
            make.left.equalTo(ivImage.snp.right).offset(5)
            make.right.equalTo(btnStar.snp.left)
        }
        
        lblDirector.snp.makeConstraints { make in
            make.top.equalTo(lblTitle.snp.bottom).offset(5)
            make.left.equalTo(lblTitle)
        }
        
        lblActor.snp.makeConstraints { make in
            make.top.equalTo(lblDirector.snp.bottom).offset(5)
            make.left.equalTo(lblDirector)
            make.right.equalToSuperview()
        }
        
        lblGrade.snp.makeConstraints { make in
            make.top.equalTo(lblActor.snp.bottom).offset(5)
            make.left.equalTo(lblActor)
        }
        
        viewDivider.snp.makeConstraints { make in
            make.top.equalTo(lblGrade.snp.bottom).offset(10)
            make.height.equalTo(0.5)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func setValue(_ data: MovieListDto.Response.Item) {
        let actors = String(data.actor.dropLast())
        
        if let url = URL(string: data.image ?? "") {
            ivImage.kf.setImage(with: url)
        }
        
        lblTitle.text = data.title.filterString(of: ["<b>", "</b>"])
        lblDirector.text = "감독: \(data.director.replace(of: "|"))"
        lblActor.text = "출연: \(actors.replace(of: "|", with: ", "))"
        lblGrade.text = "평점: \(data.userRating)"
    }
}

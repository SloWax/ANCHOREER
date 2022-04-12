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
    
    private let viewDivider = UIView().then {
        $0.backgroundColor = .lightGray.withAlphaComponent(0.1)
    }
    
    private let viewMother = UIView()
    
    private let ivImage = UIImageView()
    
    private let svLabel = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fillProportionally
    }
    
    private let lblDirector = UILabel()
    
    private let lblActor = UILabel()
    
    private let lblGrade = UILabel()
    
    let btnStar = UIButton().then {
        let image = UIImage(systemName: "star.fill")
        $0.setImage(image, for: .normal)
        $0.tintColor = .lightGray
    }
    
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
        let arrangedSubviews = [lblDirector, lblActor, lblGrade]
        svLabel.addArrangedSubviews(views: arrangedSubviews)
        
        let views = [ivImage, svLabel, btnStar]
        viewMother.addSubviews(views)
        
        addSubview(wvView)
        self.addSubviews([viewDivider, viewMother, wvView])
    }
    
    private func setLayout() {
        viewDivider.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(10)
        }
        
        viewMother.snp.makeConstraints { make in
            make.top.equalTo(viewDivider.snp.bottom)
            make.left.right.equalTo(self.safeAreaLayoutGuide)
        }
        
        ivImage.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview().inset(10)
            make.width.equalToSuperview().multipliedBy(0.225)
            make.height.equalTo(ivImage.snp.width).multipliedBy(1.3)
        }
        
        btnStar.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.1)
            make.height.equalTo(btnStar.snp.width)
        }
        
        svLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(ivImage).inset(5)
            make.left.equalTo(ivImage.snp.right).offset(10)
            make.right.equalTo(btnStar.snp.left).offset(-10)
        }
        
        wvView.snp.makeConstraints { make in
            make.top.equalTo(viewMother.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func setValue(_ data: MovieListDto.Response.Item, isFavorite: Bool) {
        let actors = String(data.actor.dropLast())
        
        if let url = URL(string: data.image ?? "") {
            ivImage.kf.setImage(with: url)
        }
        
        lblDirector.text = "감독: \(data.director.replace(of: "|"))"
        lblActor.text = "출연: \(actors.replace(of: "|", with: ", "))"
        lblGrade.text = "평점: \(data.userRating)"
        btnStar.tintColor = isFavorite ? .yellow : .lightGray
    }
}

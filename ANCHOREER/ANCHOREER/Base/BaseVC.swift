//
//  BaseVC.swift
//  ANCHOREER
//
//  Created by 표건욱 on 2022/04/10.
//

import UIKit
import RxSwift
import SwiftUI


class BaseVC: UIViewController {
    deinit {
        print("<<<<<< END \(Self.self) >>>>>>")
    }
    
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barButton = UIBarButtonItem(title: "",
                                        style: .plain,
                                        target: nil,
                                        action: #selector(backButton(_:)))
        barButton.tintColor = .gray
        navigationItem.backBarButtonItem = barButton
    }
    
    func setLeftTitle(_ title: String) {
        let label = UILabel()
        label.text = title
        label.font = .boldSystemFont(ofSize: 20)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
    }
    
    func setNavigationTitle(title: String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        
        navigationItem.titleView = titleLabel
    }
    
    func setRightFavorite() {
        let button = UIButton()
        let image = UIImage(systemName: "star.fill")
        button.setImage(image, for: .normal)
        button.setTitle("즐겨찾기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .yellow
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(rightMenu), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    // present 시 네비게이션에 x 버튼 추가
    func setLeftDismiss() {
        let button = UIButton()
        let image = UIImage(systemName: "xmark")
        button.setImage(image, for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(leftMenu), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    func clearBag(vm: BaseVM = BaseVM()) {
        vm.clearBag()
        bag = DisposeBag()
    }
    
    @objc func leftMenu() { }
    @objc func rightMenu() { }
    @objc func backButton(_ sender: UIButton) { }
}

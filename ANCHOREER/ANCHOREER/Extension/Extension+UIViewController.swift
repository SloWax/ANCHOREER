//
//  Extension+UIViewController.swift
//  ANCHOREER
//
//  Created by 표건욱 on 2022/04/10.
//

import UIKit

extension UIViewController {
    // 기본 present
    func presentVC(_ vc: UIViewController, animated: Bool = true, modal: UIModalPresentationStyle = .fullScreen, completion: (() -> Void)? = nil) {
        vc.modalPresentationStyle = modal
        
        self.present(vc, animated: animated) {
            completion?()
        }
    }
    
    // 기본 push
    func pushVC(_ vc: BaseVC, animated: Bool = true, title: String? = nil) {
        if let title = title {
            vc.setNavigationTitle(title: title)
        }
        
        self.navigationController?.pushViewController(vc, animated: animated)
    }
}

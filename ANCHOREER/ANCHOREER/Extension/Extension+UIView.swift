//
//  Extension+UIView.swift
//  ANCHOREER
//
//  Created by 표건욱 on 2022/04/10.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            self.addSubview($0)
        }
    }
}

//
//  Extension+UIStackView.swift
//  ANCHOREER
//
//  Created by 표건욱 on 2022/04/12.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(views: [UIView]) {
        views.forEach {
            self.addArrangedSubview($0)
        }
    }
}

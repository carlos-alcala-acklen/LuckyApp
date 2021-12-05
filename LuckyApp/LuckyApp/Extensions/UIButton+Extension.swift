//
//  UIButton+Extension.swift
//  LuckyApp
//
//  Created by Carlos Alcala on 4/12/2021.
//  Copyright © 2021 LuckyApp. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func makeRounded() {
        super.layoutSubviews()
        let radius: CGFloat = self.bounds.size.height / 2.0
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}

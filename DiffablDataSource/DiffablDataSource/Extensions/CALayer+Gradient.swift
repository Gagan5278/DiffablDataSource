//
//  CALayer+Gradient.swift
//  DiffablDataSource
//
//  Created by Gagan Vishal on 2019/11/01.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    func configureGradientBackground(_ colors:CGColor...){
        let gradient = CAGradientLayer()
        let maxWidth = max(self.bounds.size.height,self.bounds.size.width)
        let squareFrame = CGRect(origin: self.bounds.origin, size: CGSize(width: maxWidth, height: maxWidth))
        gradient.frame = squareFrame
        gradient.colors = colors
        self.insertSublayer(gradient, at: 0)
    }
}

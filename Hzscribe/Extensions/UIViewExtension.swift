//
//  UIViewExtension.swift
//  bose-scribe
//
//  Created by Huanzhong Huang on 8/16/16.
//  Copyright © 2016 Intrepid Pursuits LLC. All rights reserved.
//

import UIKit

extension UIView {
    
    func addTopBorder(withColor color: UIColor, andWidth borderWidth: CGFloat) {
        let subLayer = CALayer()
        subLayer.backgroundColor = color.CGColor
        subLayer.frame = CGRectMake(0.0, 0.0, frame.width, borderWidth)
        layer.addSublayer(subLayer)
    }
    
    func addBottomBorder(withColor color: UIColor, andWidth borderWidth: CGFloat) {
        let subLayer = CALayer()
        subLayer.backgroundColor = color.CGColor
        subLayer.frame = CGRectMake(0.0, frame.height - borderWidth, frame.width, borderWidth)
        layer.addSublayer(subLayer)
    }
    
}

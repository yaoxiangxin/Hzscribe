//
//  UIColorExtension.swift
//  bose-scribe
//
//  Created by Alan Scarpa on 8/15/16.
//  Copyright © 2016 Intrepid Pursuits LLC. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func bs_black() -> UIColor {
        return UIColor(colorLiteralRed: 51.0 / 255.0, green: 51.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
    }

    class func bs_coolGrey() -> UIColor {
        return UIColor(red: 174.0 / 255.0, green: 173.0 / 255.0, blue: 182.0 / 255.0, alpha: 1.0)
    }
    
    class func bs_lightGrey() -> UIColor {
        return UIColor(white: 238.0 / 255.0, alpha: 1.0)
    }
    
    class func bs_paleGray() -> UIColor {
        return UIColor(colorLiteralRed: 238.0 / 255.0, green: 238.0 / 255.0, blue: 243.0 / 255.0, alpha: 1.0)
    }
    
    class func bs_white() -> UIColor {
        return UIColor(colorLiteralRed: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }
    
}

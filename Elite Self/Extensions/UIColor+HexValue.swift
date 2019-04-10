//
//  UIColor+HexValue.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 01/10/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init? (hexValue: String, alpha: CGFloat) {
        if hexValue.hasPrefix("#") {
            let scan = Scanner(string: hexValue)
            scan.scanLocation = 1
            var hexInt32: UInt32 = 0
            if hexValue.count == 7 {
                if scan.scanHexInt32(&hexInt32) {
                    let red = CGFloat((hexInt32 & 0xFF0000) >> 16) / 255
                    let green = CGFloat((hexInt32 & 0x00FF00) >> 8) / 255
                    let blue = CGFloat(hexInt32 & 0x0000FF) / 255
                    self.init(red: red, green: green, blue: blue, alpha: alpha)
                    return
                }
            }
        }
        return nil
    }
}

extension UIColor {
    @nonobjc class var deepRed: UIColor {
        return UIColor(red: 29.0 / 255.0, green: 16.0 / 255.0, blue: 28.0 / 255, alpha: 1.0)
    }
}

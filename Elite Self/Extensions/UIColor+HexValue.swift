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
    @nonobjc class var nightBlue: UIColor {
        return UIColor(red: 20.0 / 255.0, green: 40.0 / 255.0, blue: 75.0 / 255, alpha: 1.0)
    }
	@nonobjc class var lightBlue: UIColor {
		return UIColor(red: 145.0 / 255.0, green: 175.0 / 255.0, blue: 180.0 / 255, alpha: 1.0)
	}
}

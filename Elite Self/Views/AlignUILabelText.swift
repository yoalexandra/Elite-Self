//
//  AlignUILabelText.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 30/08/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit

class AlignUILabelText: UILabel {

    override func drawText(in rect: CGRect) {
        if let stringText = text {
            let stringTextAsNSString = stringText as NSString
            let labelStringSize = stringTextAsNSString.boundingRect(with: CGSize(width: self.frame.width,height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [kCTFontAttributeName as NSAttributedString.Key: font], context: nil).size
            super.drawText(in: CGRect(x:0,y: rect.size.height - labelStringSize.height, width: self.frame.width, height: ceil(labelStringSize.height)))
        } else {
            super.drawText(in: rect)
        }
    }
}

//
//  AffirmationViewCell.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 28/10/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit

class AffirmationViewCell: UICollectionViewCell {
    
    @IBOutlet weak var affirmationViewText: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 10.0
        contentView.clipsToBounds = true
    }
}

extension AffirmationViewCell: UITextViewDelegate {
    
}

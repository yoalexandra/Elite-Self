//
//  AffirmationViewCell.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 28/10/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit

class AffirmationViewCell: UITableViewCell  {
    
    @IBOutlet weak var affirmationViewText: UILabel!
	@IBOutlet weak var shadowView: ShadowedView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
    }
	
}


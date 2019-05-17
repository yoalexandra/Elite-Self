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
	
	let cornerRadius: CGFloat = 10.0
	
    override func awakeFromNib() {
        super.awakeFromNib()
		
        contentView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
		
		shadowView.backgroundColor = UIColor.lightBlue
		shadowView.layer.cornerRadius = cornerRadius
		shadowView.layer.shadowColor = UIColor.gray.cgColor
		shadowView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
		shadowView.layer.shadowRadius = 3.0
		shadowView.layer.shadowOpacity = 0.7
    }
	
}


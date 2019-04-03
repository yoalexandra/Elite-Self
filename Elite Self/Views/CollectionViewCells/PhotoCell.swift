//
//  PhotoCell.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 07/05/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
	
	@IBOutlet weak var imageContainerView: ShadowedView!
	@IBOutlet weak var photoView: UIImageView!
	
	
	
	let cornerRadius : CGFloat = 6.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
        photoView.contentMode = .scaleAspectFill
		
		// Initialization code
		imageContainerView.layer.cornerRadius = cornerRadius
		imageContainerView.layer.shadowColor = UIColor.gray.cgColor
		imageContainerView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
		imageContainerView.layer.shadowRadius = 15.0
		imageContainerView.layer.shadowOpacity = 0.9
		
		// setting shadow path in awakeFromNib doesn't work as the bounds / frames of the views haven't got initialized yet
		// at this point the cell layout position isn't known yet
		
		photoView.layer.cornerRadius = cornerRadius
		photoView.clipsToBounds = true
        
    }
    var photo: PhotoLibrary? {
        didSet {
            if let photo = photo {
                photoView.image = photo.image
            }
        }
    }
    
}

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
	
	var photo: PhotoLibrary? {
		didSet {
			if let photo = photo {
				photoView.image = photo.image
			}
		}
	}
	
	let cornerRadius: CGFloat = 10.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 10.0
        containerView.layer.masksToBounds = true
		containerView.backgroundColor = .clear
		
		imageContainerView.layer.cornerRadius = cornerRadius
		imageContainerView.layer.shadowColor = UIColor.gray.cgColor
		imageContainerView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
		imageContainerView.layer.shadowRadius = 3.0
		imageContainerView.layer.shadowOpacity = 0.7
		
		photoView.contentMode = .scaleAspectFill
		photoView.layer.cornerRadius = cornerRadius
		photoView.clipsToBounds = true
    }
}

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
    @IBOutlet weak var photoView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
        photoView.contentMode = .scaleAspectFill
        
    }
    var photo: PhotoLibrary? {
        didSet {
            if let photo = photo {
                photoView.image = photo.image
            }
        }
    }
    
}















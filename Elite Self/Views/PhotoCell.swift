//
//  PhotoCell.swift
//  Elite Self
//
//  Created by Администратор on 07/05/2018.
//  Copyright © 2018 alejandra. All rights reserved.
//

import UIKit

protocol PhotoCellDelegate: class {
    func delete(cell: PhotoCell)
}

class PhotoCell: UICollectionViewCell {
    
    weak var delegate: PhotoCellDelegate?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var deleteViewCellBtn: UIVisualEffectView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
        photoView.contentMode = .scaleAspectFill
        deleteViewCellBtn.layer.cornerRadius = deleteViewCellBtn.bounds.width / 2.0
        deleteViewCellBtn.layer.masksToBounds = true
        deleteViewCellBtn.isHidden = !isEditing
    }
    var photo: PhotoLibrary? {
        didSet {
            if let photo = photo {
                photoView.image = photo.image
            }
        }
    }
    var isEditing: Bool = false {
        didSet {
            deleteViewCellBtn.isHidden = !isEditing
        }
    }
    
    @IBAction func deleteViewCell(_ sender: UIButton) {
        delegate?.delete(cell: self)
    }
}















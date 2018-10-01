//
//  PhotoLibrary.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 07/05/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit
import os.log

class PhotoLibrary: NSObject, NSCoding {
    var image: UIImage?
    static var DocumentsDictionary = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDictionary.appendingPathComponent("photoLibrary")
    // MARK: - Types
    struct PropertyKey {
        static let image = "image"
    }
    // MARK: - Initialization
    init?(image: UIImage?) {
        self.image = image
    }
    // MARK: - NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(image, forKey: PropertyKey.image)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        
        let image = aDecoder.decodeObject(forKey: PropertyKey.image) as? UIImage
        self.init(image: image)
    }
}


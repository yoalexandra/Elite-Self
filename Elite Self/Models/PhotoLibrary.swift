//
//  PhotoLibrary.swift
//  Elite Self
//
//  Created by Администратор on 07/05/2018.
//  Copyright © 2018 alejandra. All rights reserved.
//

import UIKit
import os.log

class PhotoLibrary: NSObject, NSCoding {
    var image: UIImage?
    //var caption: String // left it commented in case i will need it in the future updates
    static var DocumentsDictionary = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDictionary.appendingPathComponent("photoLibrary")
    // MARK: - Types
    struct PropertyKey {
        static let image = "image"
        // static let caption = "caption"
    }
    // MARK: - Initialization
    init?(image: UIImage?) { // , caption: String) {
        //guard !caption.isEmpty else { return nil }
        self.image = image
        //self.caption = caption
    }
    // MARK: - NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(image, forKey: PropertyKey.image)
        //aCoder.encode(caption, forKey: PropertyKey.caption)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        // Because photo is an optional property of Meal, just use conditional cast.
        let image = aDecoder.decodeObject(forKey: PropertyKey.image) as? UIImage
        // The name is required. If we cannot decode a name string, the initializer should fail.
        /*guard let caption = aDecoder.decodeObject(forKey: PropertyKey.caption) as? String else {
         os_log("Unable to decode the caption for a Photo caption.", log: OSLog.default, type: .debug)
         return nil
         }*/
        // Must call designated initializer.
        self.init(image: image)//, caption: caption)
    }
}































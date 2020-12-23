//
//  Manifest.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 23.12.2020.
//

import Foundation
import UIKit

struct Manifest {
    
}


class PhotoLibrary: Codable {
    
    var image: UIImage
    
    static var DocumentsDictionary = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDictionary.appendingPathComponent("photoLibrary")
    
    private enum CodingKeys: String, CodingKey {
        case image
    }
    
    // MARK: - Initialization
    init?(image: UIImage) {
        self.image = image
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let imageData = try container.decode(Data.self, forKey: .image)
        image = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(imageData) as? UIImage ?? UIImage()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
    
        let imageData = try NSKeyedArchiver.archivedData(withRootObject: image, requiringSecureCoding: false)
        try container.encode(imageData, forKey: .image)
    }
}
 

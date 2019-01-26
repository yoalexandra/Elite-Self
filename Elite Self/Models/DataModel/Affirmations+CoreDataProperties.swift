//
//  Affirmations+CoreDataProperties.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 26/01/2019.
//  Copyright © 2019 Divine App. All rights reserved.
//
//

import Foundation
import CoreData


extension Affirmations {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Affirmations> {
        return NSFetchRequest<Affirmations>(entityName: "Affirmations")
    }

    @NSManaged public var phrase: NSData?

}

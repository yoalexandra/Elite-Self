//
//  NSPersistentContainer+saveContex.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 11/04/2019.
//  Copyright © 2019 Divine App. All rights reserved.
//

import CoreData
extension NSPersistentContainer {
	
	func saveContextIfNeeded() {
		if viewContext.hasChanges {
			do {
				try viewContext.save()
			} catch {
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}
}

//
//  TemporaryPersistentContainer.swift
//  ComicList
//
//  Created by Charles Moncada on 16/11/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation
import CoreData

internal final class TemporaryPersistentContainer: NSPersistentContainer {
    
    override class func defaultDirectoryURL() -> URL {
        return URL(fileURLWithPath: NSTemporaryDirectory())
    }
    
    init(managedObjectModel model: NSManagedObjectModel) {
        super.init(name: UUID().uuidString, managedObjectModel: model)
    }
    
}

//
//  VolumeEntryRealm.swift
//  ComicList
//
//  Created by Charles Moncada on 22/11/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation
import RealmSwift

class VolumeEntryRealm: Object {
    
    dynamic var identifier = 0
    dynamic var title: String = ""
    dynamic var publisher: String? = nil
    dynamic var imageURL: String? = nil
    dynamic var insertionDate = Date()
    
//    var coverURL: URL? {
//        get {
//            return imageURL.flatMap { URL(string: $0) }
//        }
//        
//        set {
//            imageURL = newValue?.absoluteString
//        }
//    }
    
    func coverURL(_ url: String?) -> URL? {
        return url.flatMap { URL(string: $0)}
    }
    
}

extension VolumeEntryRealm {
    
    convenience init(volume: Volume) {
        
        self.init()
        identifier = volume.identifier
        title = volume.title
        imageURL = volume.coverURL?.absoluteString
        publisher = volume.publisherName
    }
    
}

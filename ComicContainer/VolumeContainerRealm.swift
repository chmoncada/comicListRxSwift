//
//  VolumeContainerRealm.swift
//  ComicList
//
//  Created by Charles Moncada on 22/11/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

/// A collection of volumes persisted in disk
//public protocol VolumeContainerType {
//    
//    /// Loads the corresponding store for the container
//    func load() -> Observable<Void>
//    
//    /// Saves an array of volumes in the container
//    func save(volumes: [Volume]) -> Observable<Void>
//    
//    /// Deletes the volume with a given identifier
//    func delete(volumeWithIdentifier: Int) -> Observable<Void>
//    
//    /// Determines if the container contains a volume with a given identifier
//    func contains(volumeWithIdentifier: Int) -> Bool
//    
//    /// Returns all the volumes in the container
//    func all() -> VolumeResultsType
//}

final public class VolumeContainerRealm {
    
    fileprivate var container: Realm
    
    private init(container: Realm) {
        self.container = container
    }
    
    public convenience init(name: String) {
        
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(name).realm")
        let container = try! Realm(configuration: config)
        
        self.init(container: container)
    }
    
    public static func temporary() -> VolumeContainerRealm {
        
        var config = Realm.Configuration()
        let temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory())
        config.fileURL = temporaryDirectoryURL.appendingPathComponent("\(UUID().uuidString).realm")
        let container = try! Realm(configuration: config)
        
        return VolumeContainerRealm(container: container)
    }
    
}

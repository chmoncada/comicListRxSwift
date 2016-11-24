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

extension VolumeContainerRealm: VolumeContainerType {
    
    public func all() -> VolumeResultsType {
        
        return VolumeResultsRealm(container: container)
        
    }
    
    public func contains(volumeWithIdentifier: Int) -> Bool {
        
        let predicate = NSPredicate(format: "identifier == %d", volumeWithIdentifier)
        let results = container.objects(VolumeEntryRealm.self).filter(predicate)
        
        if results.count > 0 {
            return true
        } else {
            return false
        }
        
    }
    
    public func load() -> Observable<Void> {
        
        return Observable.create { observer in
            
//            self.container.loadPersistentStores { _, error in
//                if let error = error {
//                    observer.onError(error)
//                } else {
//                    observer.onNext()
//                    observer.onCompleted()
//                }
//            }
            
            return Disposables.create()
        }
    }
    
    public func save(volumes: [Volume]) -> Observable<Void> {
        return performBackgroundTask { container in
            try container.write {
                for volume in volumes {
                    let volumeEntryRealm = VolumeEntryRealm(volume: volume)
                    container.add(volumeEntryRealm)
                }
            }
        }
    }
    
    public func delete(volumeWithIdentifier: Int) -> Observable<Void> {
        return performBackgroundTask { container in
            try container.write {
                let predicate = NSPredicate(format: "identifier == %d", volumeWithIdentifier)
                let result = container.objects(VolumeEntryRealm.self).filter(predicate).first
                container.delete(result!)
            }
        }
    }
    
    private func performBackgroundTask(_ task: @escaping (Realm) throws -> Void) -> Observable<Void> {
        
        return Observable.create { observer in
            
            do {
                try task(self.container)
                observer.onNext()
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    
    
}

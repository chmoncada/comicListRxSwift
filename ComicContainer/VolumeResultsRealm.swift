//
//  VolumeResultsRealm.swift
//  ComicList
//
//  Created by Charles Moncada on 23/11/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation
import RealmSwift

internal final class VolumeResultsRealm: VolumeResultsType {
    
    // MARK: - VolumeResultsType
    
    var didUpdate: () -> Void = {}
    
    var numberOfVolumes: Int {
        return results.count
    }
    
    func volume(at index: Int) -> Volume {
        
        let entryRealm = results[index]
        
        return Volume(entryRealm: entryRealm)
        
    }
    
    // MARK: - Properties
    private var results: Results<VolumeEntryRealm>
    private var token = NotificationToken()
    
    
    //MARK: - Initialization
    
    init(container: Realm) {
        results = container.objects(VolumeEntryRealm.self)
        
        token = container.addNotificationBlock { [weak self] _, _ in
            self?.didUpdate()
        }
    }
    
    deinit {
        token.stop()
    }
}

//
//  VolumeDescription.swift
//  ComicList
//
//  Created by Charles Moncada on 18/11/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation

public struct VolumeDescription {
    public let description: String?
}

extension VolumeDescription: JSONDecodable {
    
    public init?(dictionary: JSONDictionary) {
        description = dictionary["description"] as? String
    }
    
}

//
//  Suggestion.swift
//  ComicList
//
//  Created by Charles Moncada on 12/10/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation

public struct Suggestion {
    public let title: String
}

// MARK: - JSONDecodable

extension Suggestion: JSONDecodable {
    
    public init?(dictionary: JSONDictionary) {
        guard let title = dictionary["name"] as? String else {
            return nil
        }
        
        self.title = title
    }
}

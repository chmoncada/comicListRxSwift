//
//  Issue.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 03/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation
import ComicService

/// A comic issue
struct Issue {

    /// Issue title
    let title: String

    /// Cover image URL
    let coverURL: URL?
}

extension Issue: JSONDecodable {

    public init?(dictionary: JSONDictionary) {
        
        if let title = dictionary["name"] as? String {
            self.title = title
        } else {
            self.title = ""
        }
        
        self.coverURL = ((dictionary as NSDictionary)
            .value(forKeyPath: "image.small_url") as? String)
            .flatMap { URL(string: $0) }
    }

}

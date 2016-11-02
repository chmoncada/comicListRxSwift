//
//  API.swift
//  ComicList
//
//  Created by Charles Moncada on 12/10/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation

public enum API {
    case suggestions(query: String)
}

extension API: Resource {
    
    public var path: String {
        switch self {
        case .suggestions:
            return "search"
        }
    }

    public var parameters: [String : String] {
        
        switch self {
        case .suggestions(query: let q):
            return [
                "format": "json",
                "field_list": "name",
                "limit": "10",
                "page": "1",
                "query": q,
                "resources": "volume"
            ]
        }
    }
    
}

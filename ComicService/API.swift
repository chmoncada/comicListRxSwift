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
    case search(query: String, page: Int)
    case description(volumeIdentifier: Int)
    case issues(volumeIdentifier: Int)
}

extension API: Resource {
    
    public var path: String {
        switch self {
        case .suggestions, .search:
            return "search"
        case .description(volumeIdentifier: let identifier):
            return "volume/4050-\(identifier)"
        case .issues:
            return "issues"
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
        case let .search(query: q, page: p):
            return [
                "format": "json",
                "field_list": "id,image,name,publisher",
                "limit": "20",
                "page": "\(p)",
                "query": q,
                "resources": "volume"
            ]
        case .description:
            return [
                "format": "json",
                "field_list": "description",
            ]
        case let .issues(volumeIdentifier: identifier):
            return [
                "format": "json",
                "field_list": "id,image,name,volumen",
                "filter": "volume:\(identifier)"
            ]
        }
    }
    
}

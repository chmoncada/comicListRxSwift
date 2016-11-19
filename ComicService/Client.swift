//
//  Client.swift
//  ComicList
//
//  Created by Charles Moncada on 04/11/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation
import HTTPFetcher
import RxSwift

private let baseURL = URL(string: "http://www.comicvine.com/api")!
private let key = "add524ea968b57e7a1c55198a83e998410dac39d"

public enum ClientError: Error {
    case couldNotDecodeJSON
    case badStatus(Int, String)
}

public final class Client {
    
    private let fetcher: HTTPFetcher
    
    public init(fetcher: HTTPFetcher = URLSession(configuration: URLSessionConfiguration.default)) {
        self.fetcher = fetcher
    }
    
    public func object<T: JSONDecodable>(forResource resource: Resource) -> Observable<T> {
        return response(forResource: resource).map { response in
            guard let result: T = response.result() else {
                throw ClientError.couldNotDecodeJSON
            }
            
            return result
        }
    }
    
    public func objects<T: JSONDecodable>(forResource resource: Resource) -> Observable<[T]> {
        return response(forResource: resource).map { response in
            guard let results: [T] = response.results() else {
                throw ClientError.couldNotDecodeJSON
            }
            
            return results
        }
    }
    
    private func response(forResource resource: Resource) -> Observable<Response> {
        let request = resource.request(withBaseURL: baseURL, additionalParameters: ["api_key": key])
        
        return fetcher.data(request: request).map { data in
            guard let response: Response = decode(data) else {
                throw ClientError.couldNotDecodeJSON
            }
            
            guard response.succeeded else {
                throw ClientError.badStatus(response.status, response.message)
            }
            
            return response
        }
        
        
    }
}

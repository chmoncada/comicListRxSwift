//
//  AppDelegate.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 29/09/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import UIKit
@testable import ComicService

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)

        coordinator = AppCoordinator(window: window)
        coordinator?.start()
        
        
        /// PRUEBAS
        
        /* 1 Prueba de request
        let resource = API.suggestions(query: "hola gente")
        let request = resource.request(withBaseURL: URL(string:"http://example.com")!, additionalParameters: [
                "api_key": "jarl"
            ])
        print("request: \(request)")
        */
        
        /* 2 Prueba de response y suggestions
        let dictionary: JSONDictionary = [
            "error": "OK",
            "status_code": 1,
            "results": [
                [
                    "name": "Hola",
                    "resource_type": "volume"
                ],
                [
                    "name": "Gente",
                    "resource_type": "volume"
                ]
            ]
        ]
        
         if let response: Response = decode(dictionary),
            let suggestions: [Suggestion] = response.results() {
            print("response: \(response)")
            print("suggestions: \(suggestions)")
        }
        */
        
        /// FIN DE PRUEBAS

        return true
    }
}


//
//  AppConfig.swift
//  MoviesRimac
//
//  Created by Carlos on 23/04/25.
//

import Foundation

class AppConfig {
    static let shared = AppConfig()

    let apiBaseURL: String
    let apiKey: String

    private init() {
        guard
            let path = Bundle.main.path(forResource: "Environment", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path)
        else {
            fatalError("Environment.plist not found or malformed")
        }

        guard
            let apiBaseURL = dict["API_BASE_URL"] as? String,
            let apiKey = dict["API_KEY"] as? String
        else {
            fatalError("Missing keys in Environment.plist")
        }

        self.apiBaseURL = apiBaseURL
        self.apiKey = apiKey
        print("✅ API Base URL: \(apiBaseURL)")
        print("✅ API Key: \(apiKey)")
    }
}

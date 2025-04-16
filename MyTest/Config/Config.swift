//
//  Config.swift
//  MyTest
//

import Foundation

enum Config {
    enum Supabase {
        private static let configDict: [String: Any]? = {
            guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
                  let dict = NSDictionary(contentsOfFile: path) as? [String: Any] else {
                #if DEBUG
                print("⚠️ Could not load Secrets.plist file")
                #endif
                return nil
            }
            return dict
        }()
        
        static let url: URL = {
            guard let urlString = configDict?["SUPABASE_URL"] as? String,
                  let url = URL(string: urlString) else {
                fatalError("Invalid Supabase URL in configuration")
            }
            return url
        }()
        
        static let apiKey: String = {
            guard let key = configDict?["SUPABASE_API_KEY"] as? String else {
                fatalError("Supabase API key not found in configuration")
            }
            return key
        }()
    }
} 
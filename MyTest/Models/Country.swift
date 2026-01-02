//
//  Country.swift
//  MyTest
//

import Foundation

struct Country: Identifiable, Decodable, Encodable {
    var id: Int?
    var name: String
    var isVisited: Bool
    var latitude: Double
    var longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case isVisited = "is_visited"
        case latitude
        case longitude
    }
    
    // Computed property to ensure unique identifier for ForEach
    var uniqueId: String {
        if let id = id {
            return "\(id)"
        } else {
            // Fallback to a combination of name and coordinates for uniqueness
            return "\(name)_\(latitude)_\(longitude)"
        }
    }
}

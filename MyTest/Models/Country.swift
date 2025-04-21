//
//  Country.swift
//  MyTest
//

import Foundation

struct Country: Identifiable, Decodable, Encodable {
    var id: Int?
    var name: String
    var is_visited: Bool
} 

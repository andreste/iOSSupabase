//
//  SupabaseService.swift
//  MyTest
//

import Foundation
import Supabase

class SupabaseService {
    private let client: SupabaseClient

    init() {
        self.client = SupabaseClient(
            supabaseURL: Config.Supabase.url,
            supabaseKey: Config.Supabase.apiKey
        )
    }

    func fetchCountries() async throws -> [Country] {
        let fetchedCountries: [Country] = try await client
            .from("countries")
            .select()
            .execute()
            .value
        return fetchedCountries
    }
    
    func addCountry(name: String, isVisited: Bool, latitude: Double, longitude: Double) async throws {
        let country = Country(
            id: nil,
            name: name,
            isVisited: isVisited,
            latitude: latitude,
            longitude: longitude
        )
        
        let query = try client
            .from("countries")
            .insert(country)
        
        _ = try await query.execute()
    }
}

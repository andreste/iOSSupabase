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
    
    func addCountry(name: String, isVisited: Bool) async throws {
        let newCountry = Country(name: name, isVisited: isVisited)
        
        _ = try await client
            .from("countries")
            .insert(newCountry)
            .execute()
    }
}

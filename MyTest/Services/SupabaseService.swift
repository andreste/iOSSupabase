//
//  SupabaseService.swift
//  MyTest
//

import Foundation
import Supabase

class SupabaseService {
    private let client: SupabaseClient

    init(supabaseUrl: URL, supabaseKey: String) {
        self.client = SupabaseClient(supabaseURL: supabaseUrl, supabaseKey: supabaseKey)
    }

    func fetchCountries() async throws -> [Country] {
        let fetchedCountries: [Country] = try await client
            .from("countries")
            .select()
            .execute()
            .value
        return fetchedCountries
    }
}

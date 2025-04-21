import Foundation

protocol CountryService {
    func fetchCountries() async throws -> [Country]
    func addCountry(name: String, isVisited: Bool) async throws
}

extension SupabaseService: CountryService {} 
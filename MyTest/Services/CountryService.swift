import Foundation
import CoreLocation

protocol CountryService {
    func fetchCountries() async throws -> [Country]
    func addCountry(name: String, isVisited: Bool, latitude: Double, longitude: Double) async throws
}

extension SupabaseService: CountryService {} 


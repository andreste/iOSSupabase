import Foundation
import SwiftUI

@Observable
final class AddCountryViewModel {
    var name: String = ""
    var isVisited: Bool = false
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let countryService: CountryService
    private let geocodingService = GeocodingService()
    
    init(countryService: CountryService) {
        self.countryService = countryService
    }
    
    func saveCountry() async throws -> Country {
        guard !name.isEmpty else {
            errorMessage = "Country name cannot be empty"
            throw NSError(domain: "AddCountryViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "Country name cannot be empty"])
        }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            // Get coordinates for the country
            let coordinates = try await geocodingService.getCoordinates(for: name)
            
            // Add country to Supabase
            try await countryService.addCountry(
                name: name,
                isVisited: isVisited,
                latitude: coordinates.latitude,
                longitude: coordinates.longitude
            )
            
            // Create and return the new country object
            return Country(
                id: nil,
                name: name,
                isVisited: isVisited,
                latitude: coordinates.latitude,
                longitude: coordinates.longitude
            )
        } catch {
            errorMessage = "Failed to save country: \(error.localizedDescription)"
            throw error
        }
    }
} 

import Foundation
import SwiftUI

@Observable
final class AddCountryViewModel {
    var name: String = ""
    var isVisited: Bool = false
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let countryService: CountryService
    
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
            try await countryService.addCountry(name: name, isVisited: isVisited)

            // Create a new country object with the provided data
            // Note: The id will be set by Supabase, but we don't need it for this purpose
            return Country(id: nil, name: name, isVisited: isVisited)

        } catch {
            errorMessage = "Failed to save country: \(error.localizedDescription)"
            throw error
        }
    }
} 

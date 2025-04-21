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
    
    func saveCountry() async throws {
        guard !name.isEmpty else {
            errorMessage = "Country name cannot be empty"
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await countryService.addCountry(name: name, isVisited: isVisited)
        } catch {
            errorMessage = "Failed to save country: \(error.localizedDescription)"
            throw error
        }
    }
} 

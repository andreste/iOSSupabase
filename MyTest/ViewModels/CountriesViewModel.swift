//
//  CountriesViewModel.swift
//  MyTest
//

import Foundation
import Combine

@MainActor
class CountriesViewModel: ObservableObject {
    @Published var countries: [Country] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    var countryService: CountryService
    
    init(countryService: CountryService) {
        self.countryService = countryService
        Task {
            await fetchCountries()
        }
    }
    
    func fetchCountries() async {
        isLoading = true
        do {
            let fetched = try await countryService.fetchCountries()
            if countries != fetched {
                countries = [] // Force UI update via empty assignment
                await Task.yield() // Yield so SwiftUI can process change
            }
            countries = fetched
            errorMessage = nil
        } catch {
            errorMessage = "Failed to fetch countries: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    func appendCountry(_ country: Country) {
        // Add the new country to the beginning of the list
        countries.append(country)
    }
}

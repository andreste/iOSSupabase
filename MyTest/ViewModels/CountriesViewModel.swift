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
    
    let countryService: CountryService
    
    init(countryService: CountryService) {
        self.countryService = countryService
        fetchCountries()
    }
    
    func fetchCountries() {
        isLoading = true
        Task {
            do {
                countries = try await countryService.fetchCountries()
            } catch {
                errorMessage = "Failed to fetch countries: \(error.localizedDescription)"
            }
            isLoading = false
        }
    }
}

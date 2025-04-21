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
    
    private let supabaseService: SupabaseService
    
    init() {
        self.supabaseService = ServiceContainer.shared.supabaseService
        fetchCountries()
    }
    
    func fetchCountries() {
        isLoading = true
        Task {
            do {
                countries = try await supabaseService.fetchCountries()
            } catch {
                errorMessage = "Failed to fetch countries: \(error.localizedDescription)"
            }
            isLoading = false
        }
    }
}

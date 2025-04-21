import Foundation
import SwiftUI

@Observable
final class AddCountryViewModel {
    var name: String = ""
    var isVisited: Bool = false
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let supabaseService: SupabaseService
    
    init() {
        self.supabaseService = ServiceContainer.shared.supabaseService
    }
    
    func saveCountry() async throws {
        guard !name.isEmpty else {
            errorMessage = "Country name cannot be empty"
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await supabaseService.addCountry(name: name, isVisited: isVisited)
        } catch {
            errorMessage = "Failed to save country: \(error.localizedDescription)"
            throw error
        }
    }
} 

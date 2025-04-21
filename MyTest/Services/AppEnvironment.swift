import SwiftUI

@Observable
final class AppEnvironment {
    let countryService: CountryService
    
    init(countryService: CountryService = SupabaseService()) {
        self.countryService = countryService
    }
} 
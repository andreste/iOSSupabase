import Foundation

final class ServiceContainer {
    static let shared = ServiceContainer()
    
    let supabaseService: SupabaseService
    
    private init() {
        self.supabaseService = SupabaseService()
    }
} 
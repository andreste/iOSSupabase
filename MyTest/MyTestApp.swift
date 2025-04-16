//
//  MyTestApp.swift
//  MyTest
//

import SwiftUI

@main
struct MyTestApp: App {
    var body: some Scene {
        WindowGroup {
            let supabaseService = SupabaseService()
            ContentView(viewModel: CountriesViewModel(supabaseService: supabaseService))
        }
    }
}

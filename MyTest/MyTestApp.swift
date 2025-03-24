//
//  MyTestApp.swift
//  MyTest
//

import SwiftUI

@main
struct MyTestApp: App {
    var body: some Scene {
        WindowGroup {
            let supabaseService = SupabaseService(supabaseUrl: URL(string: "https://gdvtatkfgpakhfsnsawp.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdkdnRhdGtmZ3Bha2hmc25zYXdwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY1NDkxMTksImV4cCI6MjA1MjEyNTExOX0.2zVlMQ4ZTG8SMsmYuEA37GWdBLcKcB83xFI24bmnlzc")
            ContentView(viewModel: CountriesViewModel(supabaseService: supabaseService))
        }
    }
}

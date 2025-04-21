//
//  MyTestApp.swift
//  MyTest
//

import SwiftUI

@main
struct MyTestApp: App {
    @State private var environment = AppEnvironment()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(environment)
        }
    }
}

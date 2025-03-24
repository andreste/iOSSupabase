//
//  ContentView.swift
//  MyTest
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: CountriesViewModel

    init(viewModel: CountriesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            } else {
                List(viewModel.countries) { country in
                    Text(country.name)
                }
            }
        }
        .padding()
        .onAppear {
            Task {
                await viewModel.fetchCountries()
            }
        }
    }
} 

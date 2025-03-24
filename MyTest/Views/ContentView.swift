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
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.headline)
                        .padding()
                } else {
                    // Centered list in a rounded container
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(viewModel.countries) { country in
                                VStack(alignment: .leading) {
                                    Text(country.name)
                                        .font(.title2) // Increased font size
                                        .fontWeight(.bold)
                                        .padding()
                                }
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.white.opacity(0.9)) // Semi-transparent background
                                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2) // Subtle shadow
                                )
                                .padding(.horizontal)
                            }
                        }
                        .padding(8) // Set outer VStack to full width with padding of 8
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .onAppear {
            Task {
                viewModel.fetchCountries()
            }
        }
    }
} 

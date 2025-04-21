//
//  ContentView.swift
//  MyTest
//

import SwiftUI

struct ContentView: View {
    @Environment(AppEnvironment.self) private var environment
    @StateObject private var viewModel: CountriesViewModel
    @State private var showingAddCountry = false
    
    init() {
        // Initialize with a temporary service, will be updated in onAppear
        _viewModel = StateObject(wrappedValue: CountriesViewModel(countryService: SupabaseService()))
    }
    
    var body: some View {
        NavigationStack {
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
                            VStack(spacing: 12) {
                                ForEach(viewModel.countries, id: \.id) { country in
                                    NavigationLink(destination: CountryDetailView(countryName: country.name)) {
                                        CountryCardView(country: country)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .padding(.horizontal)
                                }
                            }
                            .padding(.vertical, 8)
                        }
                    }
                }
                
                // Floating Action Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            showingAddCountry = true
                        } label: {
                            Image(systemName: "plus")
                                .font(.title2.weight(.semibold))
                                .foregroundColor(.white)
                                .frame(width: 56, height: 56)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                        }
                        .padding()
                        .scaleEffect(showingAddCountry ? 0.9 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: showingAddCountry)
                    }
                }
            }
            .sheet(isPresented: $showingAddCountry) {
                AddCountryView(viewModel: AddCountryViewModel(countryService: environment.countryService))
                    .onDisappear {
                        viewModel.fetchCountries()
                    }
            }
            .onAppear {
                // Update the view model with the environment's service
                viewModel.countryService = environment.countryService
                viewModel.fetchCountries()
            }
        }
    }
} 

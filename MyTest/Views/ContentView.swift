//
//  ContentView.swift
//  MyTest
//

import SwiftUI

struct ContentView: View {
    @Environment(AppEnvironment.self) private var environment
    @StateObject private var viewModel: CountriesViewModel
    @State private var showingAddCountry = false
    @Namespace private var animation
    @State private var selectedCountry: Country? = nil
    
    init() {
        _viewModel = StateObject(wrappedValue: CountriesViewModel(countryService: SupabaseService()))
    }
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            if selectedCountry == nil {
                // Main list view
                VStack {
                    if viewModel.isLoading && viewModel.countries.isEmpty {
                        // Only show loading indicator on initial load when list is empty
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .padding()
                    } else if let errorMessage = viewModel.errorMessage, viewModel.countries.isEmpty {
                        // Only show error message if list is empty
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.headline)
                            .padding()
                    } else {
                        // Centered list in a rounded container
                        ScrollView {
                            VStack(spacing: 12) {
                                ForEach(viewModel.countries, id: \.uniqueId) { country in
                                    CountryCardView(country: country, namespace: animation)
                                        .onTapGesture {
                                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                                selectedCountry = country
                                            }
                                        }
                                        .padding(.horizontal)
                                }
                            }
                            .padding(.vertical, 8)
                        }
                        .refreshable {
                            Task.detached {
                                await viewModel.fetchCountries()
                            }
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
            } else if let country = selectedCountry {
                // Detail view
                CountryDetailView(
                    country: country,
                    namespace: animation,
                    onDismiss: {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            selectedCountry = nil
                        }
                    }
                )
            }
        }
        .sheet(isPresented: $showingAddCountry) {
            AddCountryView(viewModel: AddCountryViewModel(countryService: environment.countryService)) { newCountry in
                viewModel.appendCountry(newCountry)
            }
        }
        .onAppear {
            // Update the view model with the environment's service
            viewModel.countryService = environment.countryService
            Task {
                await viewModel.fetchCountries()
            }
        }
    }
}

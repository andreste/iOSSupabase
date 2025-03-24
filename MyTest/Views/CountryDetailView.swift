//
//  CountryDetailView.swift
//  MyTest
//

import SwiftUI

struct CountryDetailView: View {
    var countryName: String

    var body: some View {
        VStack {
            Text(countryName)
                .font(.largeTitle) // Large font for the country name
                .fontWeight(.bold)
                .padding()
                .multilineTextAlignment(.center) // Center the text
        }
        .navigationTitle("Country Details") // Title for the navigation bar
        .navigationBarTitleDisplayMode(.inline) // Display title inline
    }
}

struct CountryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailView(countryName: "Sample Country")
    }
} 
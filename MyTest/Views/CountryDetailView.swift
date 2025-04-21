//
//  CountryDetailView.swift
//  MyTest
//

import SwiftUI
import MapKit

struct CountryDetailView: View {
    var country: Country
    
    private var region: MapCameraPosition {
        let coordinate = CLLocationCoordinate2D(
            latitude: country.latitude,
            longitude: country.longitude
        )
        return .region(MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 30, longitudeDelta: 30)
        ))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Map View
            Map(position: .constant(region)) {
                Marker(country.name, coordinate: CLLocationCoordinate2D(
                    latitude: country.latitude,
                    longitude: country.longitude
                ))
            }
            .mapStyle(.standard)
            .frame(height: 300)
            
            // Country Info
            VStack(spacing: 16) {
                Text(country.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                HStack {
                    Image(systemName: country.isVisited ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(country.isVisited ? .green : .gray)
                    Text(country.isVisited ? "Visited" : "Not Visited")
                        .foregroundColor(country.isVisited ? .green : .gray)
                }
                .font(.title3)
            }
            .padding()
        }
        .navigationTitle("Country Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

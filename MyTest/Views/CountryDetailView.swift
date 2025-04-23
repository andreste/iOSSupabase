//
//  CountryDetailView.swift
//  MyTest
//

import SwiftUI
import MapKit

struct CountryDetailView: View {
    var country: Country
    let namespace: Namespace.ID
    var onDismiss: () -> Void
    
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
            // Top navigation bar
            HStack {
                Button(action: onDismiss) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(.blue)
                }
                .padding()
                
                Spacer()
                
                Text("Country Details")
                    .font(.headline)
                
                Spacer()
            }
            
            // Map View
            Map(position: .constant(region)) {
                Marker(country.name, coordinate: CLLocationCoordinate2D(
                    latitude: country.latitude,
                    longitude: country.longitude
                ))
            }
            .mapStyle(.hybrid)
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.main.bounds.height * 0.5)
            
            // Country Info at bottom
            VStack(spacing: 16) {
                Text(country.name)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .matchedGeometryEffect(id: "countryName_\(country.name)", in: namespace)
                
                HStack {
                    Image(systemName: country.isVisited ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(country.isVisited ? .green : .gray)
                    Text(country.isVisited ? "Visited" : "Not Visited")
                        .foregroundColor(country.isVisited ? .green : .gray)
                        .font(.subheadline)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color.white)
    }
}

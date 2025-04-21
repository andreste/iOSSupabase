import Foundation
import CoreLocation

class GeocodingService {
    private let geocoder = CLGeocoder()
    
    func getCoordinates(for countryName: String) async throws -> (latitude: Double, longitude: Double) {
        let location = try await geocoder.geocodeAddressString(countryName)
        guard let coordinate = location.first?.location?.coordinate else {
            throw NSError(domain: "GeocodingService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Could not find coordinates for country"])
        }
        return (coordinate.latitude, coordinate.longitude)
    }
} 
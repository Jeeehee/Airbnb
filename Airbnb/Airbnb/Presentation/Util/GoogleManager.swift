//
//  GoogleManager.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/09/14.
//

import Foundation
import GoogleMaps
import GooglePlaces

final class GoogleManager {
    static let shared = GoogleManager()
    
    private let apiKey = "AIzaSyDaYW2u3x9tAAk_N22v2DNTo04qhWqyjis"
    private let client = GMSPlacesClient.shared()

    private init() {
    }

    func setUp() {
        GMSServices.provideAPIKey(apiKey)
        GMSPlacesClient.provideAPIKey(apiKey)
    }
    
    func getCurrentPlace() -> CLLocationCoordinate2D {
        var coordinate = CLLocationCoordinate2D()
        let placeFields: GMSPlaceField = [.name, .formattedAddress, .coordinate]
        client.findPlaceLikelihoodsFromCurrentLocation(
            withPlaceFields: placeFields) { [weak self] placeLikelihoods, error in
                guard let strongSelf = self else { return }
                
                guard error == nil else {
                  print("Current place error: \(error?.localizedDescription ?? "")")
                  return
                }

                guard let place = placeLikelihoods?.first?.place else {
                  return
                }
                print(place.coordinate)
                coordinate = place.coordinate
            }
        print(coordinate)
        return coordinate
    }
}

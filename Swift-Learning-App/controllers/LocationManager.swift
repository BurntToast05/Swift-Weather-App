//
//  LocationManager.swift
//  Swift-Learning-App
//
//  Created by Corbin Gollaher on 8/17/22.
//

import SwiftUI
import Foundation
import CoreLocation
import MapKit

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var weather: WeatherResponse?
    @Published var userTown: String = ""
    @Published var weatherForecast: WeatherForecast?
    @Published var loading: Bool = true

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    struct ReversedGeoLocation {
            let name: String            // eg. Apple Inc.
            let streetName: String      // eg. Infinite Loop
            let streetNumber: String    // eg. 1
            let city: String            // eg. Cupertino
            let state: String           // eg. CA
            let zipCode: String         // eg. 95014
            let country: String         // eg. United States
            let isoCountryCode: String  // eg. US

            var formattedAddress: String {
                return """
                \(name),
                \(streetNumber) \(streetName),
                \(city), \(state) \(zipCode)
                \(country)
                """
            }

            // Handle optionals as needed
            init(with placemark: CLPlacemark) {
                self.name           = placemark.name ?? ""
                self.streetName     = placemark.thoroughfare ?? ""
                self.streetNumber   = placemark.subThoroughfare ?? ""
                self.city           = placemark.locality ?? ""
                self.state          = placemark.administrativeArea ?? ""
                self.zipCode        = placemark.postalCode ?? ""
                self.country        = placemark.country ?? ""
                self.isoCountryCode = placemark.isoCountryCode ?? ""
            }
        }
    // This file was generated from JSON Schema using quicktype, do not modify it directly.
    // To parse the JSON, add this file to your project and do:
    //
    //   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        DispatchQueue.main.async {
            self.location = location.coordinate
            self.getTown(lat: CLLocationDegrees.init(location.coordinate.latitude), long: CLLocationDegrees.init(location.coordinate.longitude))
            self.getCurrentWeather(latitude: location.coordinate.latitude.description, longitude: location.coordinate.longitude.description )
            self.getWeatherForecast(latitude: location.coordinate.latitude.description, longitude: location.coordinate.longitude.description)
        }
    
    }
    
    func getCurrentWeather(latitude: String, longitude: String) {
        Task {
            let (data, _) = try await URLSession.shared.data(from: URL(string:"https://api.openweathermap.org/data/2.5/weather?units=imperial&lat=\(String(describing: latitude))&lon=\(String(describing: longitude))&appid=a6c879a1a35422eec93b5702a4ae4aaf")!)
            let decodedResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            DispatchQueue.main.async {
                self.weather = decodedResponse;
            }
        }
    }
    
    func getWeatherForecast(latitude: String, longitude: String) {
        Task {
            do {
            let (data, _) = try await URLSession.shared.data(from: URL(string:"https://api.openweathermap.org/data/2.5/forecast?units=imperial&lat=\(String(describing: latitude))&lon=\(String(describing: longitude))&appid=a6c879a1a35422eec93b5702a4ae4aaf")!)
          
            let decodedResponse = try JSONDecoder().decode(WeatherForecast.self, from: data);
                DispatchQueue.main.async {
                    self.weatherForecast = decodedResponse
                    self.loading = false;

                }
            }
            catch {
                print(error);
            }
            
            
        }
    }
    
    func getTown(lat: CLLocationDegrees, long: CLLocationDegrees) -> Void
        {
            let location = CLLocation.init(latitude: lat, longitude: long)
            CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in

                guard let placemark = placemarks?.first else {
                    let errorString = error?.localizedDescription ?? "Unexpected Error"
                    print("Unable to reverse geocode the given location. Error: \(errorString)")
                    return
                }

                let reversedGeoLocation = ReversedGeoLocation(with: placemark)
                print(reversedGeoLocation.city)
                
                DispatchQueue.main.async {
                    self.userTown = "\(reversedGeoLocation.city), \(                 reversedGeoLocation.state)"
                }
            }

        }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //Handle any errors here...
        print (error)
    }
}

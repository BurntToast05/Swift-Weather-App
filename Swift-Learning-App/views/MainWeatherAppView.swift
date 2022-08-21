//
//  ContentView.swift
//  Swift-Learning-App
//
//  Created by Corbin Gollaher on 8/14/22.
//

import SwiftUI
import Foundation
import CoreLocation
import MapKit


extension Color {
    static let lightBlue = Color(red: 110 / 255, green: 165 / 255, blue: 245 / 255)
}

struct MainWeatherAppView: View {
    @StateObject var weatherController = WeatherController()

    init() {
        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithTransparentBackground()
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
    }


    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.blue, Color.lightBlue]), startPoint: UnitPoint.top, endPoint: UnitPoint.bottom).ignoresSafeArea()

                    if (weatherController.loading)
                    {
                        ProgressView()
                    }
                    else {
                        ScrollView() {
                            VStack(spacing: 1) {
                                CurrentForecastHeader(weatherController: weatherController)
                                HourlyCardScrollingView(weatherList: weatherController.weatherForecast?.list)
                                FiveDayForecastView(weatherList: weatherController.weatherForecast?.list)
                                CurrentForecastInfoGrid(weather: weatherController.weather)
                            }
                        }
                    }
                }
            }
        }.accentColor(Color.white).ignoresSafeArea()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainWeatherAppView()
        }
    }
}


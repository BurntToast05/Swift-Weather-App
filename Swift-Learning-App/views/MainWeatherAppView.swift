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
    @StateObject var locationManager = LocationManager()

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

                    if (locationManager.loading)
                    {
                        ProgressView()
                    }
                    else {
                        ScrollView() {
                            VStack(spacing: 0) {
                                Text(locationManager.userTown)
                                    .font(.system(size: 28))
                                    .foregroundColor(Color.white)
                                    .fontWeight(.semibold).padding(.top, 15)
                                Image(systemName: getIconString(code: locationManager.weather?.weather.first?.id ?? 1000)).renderingMode(.original).resizable().aspectRatio(contentMode: .fit).frame(width: 120, height: 120, alignment: .center)
                                Text("\(locationManager.weather?.weather.first?.weatherDescription.capitalized ?? "")")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color.white)
                                    .fontWeight(.semibold).multilineTextAlignment(.center)
                                Text("\(String(Int(locationManager.weather?.main.temp ?? 00)))°")
                                    .font(.system(size: 80))
                                    .foregroundColor(Color.white)
                                    .fontWeight(.semibold).multilineTextAlignment(.center)

                                HStack { Text("High:\(String(Int(locationManager.weather?.main.tempMax ?? 00)))°")
                                        .font(.system(size: 15))
                                        .foregroundColor(Color.white)
                                        .fontWeight(.semibold).multilineTextAlignment(.center)
                                    Text("Low: \(String(Int(locationManager.weather?.main.tempMin ?? 00)))°")
                                        .font(.system(size: 15))
                                        .foregroundColor(Color.white)
                                        .fontWeight(.semibold).multilineTextAlignment(.center)
                                    Text("Feels Like: \(String(Int(locationManager.weather?.main.feelsLike ?? 00)))°")
                                        .font(.system(size: 15))
                                        .foregroundColor(Color.white)
                                        .fontWeight(.semibold).multilineTextAlignment(.center)
                                }

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 5) {
                                        ForEach(locationManager.weatherForecast?.list ?? [], id: \.dt) { weather in
                                            NavigationLink(destination: HourlyForecastDetailView(weather: weather)) {
                                                HourlyCardView(icon: getIconString(code: weather.weather.first?.id ?? 0), day: getTimeFromUTC(utc: weather.dt), date: getDateFromUTC(utc: weather.dt), temp: Int(weather.main.temp))
                                            }.navigationBarHidden(true)
                                        }.padding(.top, 15).padding(.bottom, 10).padding(.leading, 3).padding(.trailing, 3)
                                            .symbolVariant(.fill)
                                            .foregroundColor(.white)

                                    }
                                }
                                VStack() {
                                    HStack {
                                        Text("Day").foregroundColor(Color.white)
                                            .fontWeight(.semibold).frame(maxWidth: .infinity, alignment: .leading)
                                        Text("Weather").foregroundColor(Color.white)
                                            .fontWeight(.semibold).frame(maxWidth: .infinity, alignment: .center)
                                        Text("Low").foregroundColor(Color.white)
                                            .fontWeight(.semibold).frame(maxWidth: .infinity)
                                        Text("High").foregroundColor(Color.white)
                                            .fontWeight(.semibold).frame(maxWidth: .infinity)

                                    }
                                    Divider().background(Color.white)
                                    ForEach(locationManager.weatherForecast?.list ?? [], id: \.dt) { weather in
                                        if (getTimeFromUTC(utc: weather.dt) == "8 AM")
                                        {
                                            HStack(spacing: 0) {
                                                Text(getDayFromUTC(utc: weather.dt)).foregroundColor(Color.white).frame(maxWidth: .infinity, alignment: .leading)
                                                Image(systemName: getIconString(code: weather.weather.first?.id ?? 1000)).renderingMode(.original).resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25, alignment: .top) .frame(maxWidth: .infinity)
                                                Text("\(String(Int(weather.main.tempMin)))°").foregroundColor(Color.white).frame(maxWidth: .infinity)
                                                Text("\(String(Int(weather.main.tempMax)))°").foregroundColor(Color.white).frame(maxWidth: .infinity)
                                            }
                                            Divider().background(Color.white)
                                        }
                                    }
                                }.padding(.leading, 2).padding(.top, 10)
                                CurrentForecastInfoGrid(weather: locationManager.weather)
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


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



struct ContentView: View {
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

                            HStack { Text("High: \(String(Int(locationManager.weather?.main.tempMax ?? 00)))°")
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
                                        NavigationLink(destination: DetailView(weather: weather)) {
                                            HourlyViewCard(icon: getIconString(code: weather.weather.first?.id ?? 0), day: getTimeFromUTC(utc: weather.dt), date: getDateFromUTC(utc: weather.dt), temp: Int(weather.main.temp))
                                        }.navigationBarHidden(true)
                                    }.padding(.top, 15).padding(.bottom, 10).padding(.leading, 3).padding(.trailing, 3)
                                        .symbolVariant(.fill)
                                        .foregroundColor(.white)

                                } }
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
                                    if (getTimeFromUTC(utc: weather.dt) == "9 AM")
                                    {
                                        HStack {
                                            Text(getDayFromUTC(utc: weather.dt)).foregroundColor(Color.white).frame(maxWidth: .infinity, alignment: .leading)
                                            Image(systemName: getIconString(code: weather.weather.first?.id ?? 1000)).renderingMode(.original).resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25, alignment: .top) .frame(maxWidth: .infinity)
                                            Text("\(String(Int(weather.main.tempMin)))°").foregroundColor(Color.white).frame(maxWidth: .infinity)
                                            Text("\(String(Int(weather.main.tempMax)))°").foregroundColor(Color.white).frame(maxWidth: .infinity)
                                        }
                                        Divider().background(Color.white)
                                    }
                                }
                            }.padding(.leading, 5).padding(.top, 10)
                        }
                    }
                }
            }
        }.accentColor(Color.white).ignoresSafeArea()
    }
}

func getIconString(code: Int) -> String {
    if (code <= 210)
    {
        return "cloud.bolt.rain.fill"
    }
    if (code <= 232)
    {
        return "cloud.bolt.rain.fill"
    }
    if (code <= 311)
    {
        return "cloud.drizzle.fill"
    }
    if (code <= 321)
    {
        return "cloud.drizzle.fill"
    }
    if (code <= 502)
    {
        return "cloud.heavyrain.fill"
    }
    if (code <= 504)
    {
        return "cloud.heavyrain.fill"
    }
    if (code <= 531)
    {
        return "cloud.hail.fill"
    }
    if (code <= 622)
    {
        return "cloud.snow.fill"
    }
    if (code <= 799)
    {
        return "smoke.fill"
    }
    if (code <= 800)
    {
        return "sun.max.fill"
    }
    if (code <= 803)
    {
        return "cloud.sun.fill"
    }
    if (code <= 805)
    {
        return "cloud.fill"
    }
    return ""

}

func getDateFromUTC(utc: Int) -> String
{
    let date = Date(timeIntervalSince1970: Double(utc))
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "M/d" //Specify your format that you want
    let strDate = dateFormatter.string(from: date)
    return strDate;
}
func getDayFromUTC(utc: Int) -> String
{
    let date = Date(timeIntervalSince1970: Double(utc))
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "EEEE" //Specify your format that you want
    let strDate = dateFormatter.string(from: date).capitalized
    return strDate;
}

func getTimeFromUTC(utc: Int) -> String
{
    let date = Date(timeIntervalSince1970: Double(utc))
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "h a" //Specify your format that you want
    dateFormatter.amSymbol = "AM"
    dateFormatter.pmSymbol = "PM"
    let strDate = dateFormatter.string(from: date)
    return strDate;
}

struct HourlyViewCard: View {
    var icon: String
    var day: String
    var date: String
    var temp: Int

    var body: some View {
        VStack(spacing: 0) {
            Text(date)
                .font(.system(size: 12))
                .foregroundColor(Color.white).multilineTextAlignment(.center)
            Text(day)
                .font(.system(size: 12))
                .foregroundColor(Color.white).multilineTextAlignment(.center)
            Image(systemName: icon).renderingMode(.original).resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50, alignment: .center).padding(3)
            Text("\(temp)°")
                .font(.system(size: 25))
                .foregroundColor(Color.white).multilineTextAlignment(.center)
        }.padding(5).cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white, lineWidth: 2))
            .shadow(radius: 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}


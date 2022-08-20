//
//  DetailView.swift
//  Swift-Learning-App
//
//  Created by Corbin Gollaher on 8/18/22.
//

import SwiftUI

struct DetailView: View {
    var weather: WeatherList?

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.lightBlue]), startPoint: UnitPoint.top, endPoint: UnitPoint.bottom).ignoresSafeArea()

            ScrollView() {
                VStack(spacing: 0) {
                    Text(getDayFromUTC(utc: weather?.dt ?? 0))
                        .font(.system(size: 30))
                        .foregroundColor(Color.white).multilineTextAlignment(.center)
                    Text("\(getDateFromUTC(utc: weather?.dt ?? 0)): \(getTimeFromUTC(utc: weather?.dt ?? 0))")
                        .font(.system(size: 30))
                        .foregroundColor(Color.white).multilineTextAlignment(.center)
                    Image(systemName: getIconString(code: weather?.weather.first?.id ?? 1000)).renderingMode(.original).resizable().aspectRatio(contentMode: .fit).frame(width: 120, height: 120, alignment: .center)
                    Text("\(weather?.weather.first?.weatherDescription.capitalized ?? "")")
                        .font(.system(size: 20))
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold).multilineTextAlignment(.center)
                    Text("\(String(Int(weather?.main.temp ?? 00)))°")
                        .font(.system(size: 80))
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold).multilineTextAlignment(.center).padding(0)
                    DetailedInfo(weather: weather).padding(.top, 10)
                    Spacer()
                }
            }
        }.navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailedInfo: View {
    var weather: WeatherList?

    var body: some View {

        VStack(alignment: .leading) {
            Divider().background(Color.white)
            SubDetailHorizontalView(titleText: "Visibility:", valueText: "\(String((weather?.visibility ?? 0) / 1000))km", titleText2: "Clouds:", valueText2: "\(String(weather?.clouds.all ?? 0))%")
            SubDetailHorizontalView(titleText: "Wind Speed:", valueText: "\(String(weather?.wind.speed ?? 0))", titleText2: "Wind Gust:", valueText2: "\(String(weather?.wind.gust ?? 0))mph")
            SubDetailHorizontalView(titleText: "Wind Direction:", valueText: "\(compassDirection(heading: Double(weather?.wind.deg ?? 0)) ?? "")", titleText2: "Precipation:", valueText2: "\(String(weather?.pop ?? 0))%")
            SubDetailHorizontalView(titleText: "Rain Volume:", valueText: "\(String((weather?.rain?.the3H ?? 0) * 10))cm", titleText2: "Humidity:", valueText2: "\(String(weather?.main.humidity ?? 0))%")
            SubDetailHorizontalView(titleText: "Feels Like:", valueText: "\(String(weather?.main.feelsLike ?? 0))°", titleText2: "Pressure:", valueText2: "\(String(weather?.main.pressure ?? 0))hPa")
            Spacer()
        }
    }

    func compassDirection(heading: Double) -> String? {
        if heading < 0 { return nil }
        let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
        let index = Int((heading + 22.5) / 45.0) & 7
        return directions[index]
    }
}

struct SubDetailHorizontalView: View {
    var titleText: String
    var valueText: String
    var titleText2: String
    var valueText2: String

    var body: some View {
        HStack {
            VStack {
                Text(titleText).foregroundColor(Color.white).fontWeight(.semibold)
                Text(valueText).foregroundColor(Color.white)
                    .fontWeight(.semibold).frame(maxWidth: .infinity)
            }
            VStack {
                Text(titleText2).foregroundColor(Color.white).fontWeight(.semibold)
                Text(valueText2).foregroundColor(Color.white)
                    .fontWeight(.semibold).frame(maxWidth: .infinity)
            }
        }.padding(2)
        Divider().background(Color.white)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

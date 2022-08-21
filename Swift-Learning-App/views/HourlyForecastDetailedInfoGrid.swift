//
//  SwiftUIView.swift
//  Swift-Learning-App
//
//  Created by Corbin Gollaher on 8/20/22.
//

import SwiftUI

struct HourlyForecastDetailedInfoGrid: View {
    var weather: WeatherList?

    var body: some View {

        VStack(alignment: .leading) {
            Divider().background(Color.white)
            DetailedInfoGridItem(titleText: "Visibility:", valueText: "\(String((weather?.visibility ?? 0) / 1000))km", titleText2: "Clouds:", valueText2: "\(String(weather?.clouds.all ?? 0))%")
            DetailedInfoGridItem(titleText: "Wind Speed:", valueText: "\(String(weather?.wind.speed ?? 0))", titleText2: "Wind Gust:", valueText2: "\(String(weather?.wind.gust ?? 0))mph")
            DetailedInfoGridItem(titleText: "Wind Direction:", valueText: "\(compassDirection(heading: Double(weather?.wind.deg ?? 0)) ?? "")", titleText2: "Precipation:", valueText2: "\(String(((weather?.pop ?? 0) * 100) ))%")
            DetailedInfoGridItem(titleText: "Rain Volume:", valueText: "\(String((weather?.rain?.the3H ?? 0)))mm", titleText2: "Humidity:", valueText2: "\(String(weather?.main.humidity ?? 0))%")
            DetailedInfoGridItem(titleText: "Feels Like:", valueText: "\(String(weather?.main.feelsLike ?? 0))°", titleText2: "Pressure:", valueText2: "\(String(weather?.main.pressure ?? 0))hPa")
            Spacer()
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyForecastDetailedInfoGrid()
    }
}

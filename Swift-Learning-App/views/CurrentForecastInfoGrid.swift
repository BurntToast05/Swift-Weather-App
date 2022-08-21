//
//  CurrentForecastInfoGrid.swift
//  Swift-Learning-App
//
//  Created by Corbin Gollaher on 8/20/22.
//

import SwiftUI

struct CurrentForecastInfoGrid: View {
    var weather: WeatherResponse?

    var body: some View {
        VStack(alignment: .leading) {
            Divider().background(Color.white)
            DetailedInfoGridItem(titleText: "Visibility:", valueText: "\(String((weather?.visibility ?? 0) / 1000))km", titleText2: "Clouds:", valueText2: "\(String(weather?.clouds.all ?? 0))%")
            DetailedInfoGridItem(titleText: "Wind Speed:", valueText: "\(String(weather?.wind.speed ?? 0))", titleText2: "Wind Direction:", valueText2: "\(compassDirection(heading: Double(weather?.wind.deg ?? 0)) ?? "")")
            DetailedInfoGridItem(titleText: "Humidity:", valueText: "\(String(weather?.main.humidity ?? 0))%", titleText2: "Pressure:", valueText2: "\(String(weather?.main.pressure ?? 0))hPa")
            Spacer()
        }
    }
}

struct CurrentForecastInfoGrid_Previews: PreviewProvider {
    static var previews: some View {
        CurrentForecastInfoGrid()
    }
}

//
//  HourlyCardScrollingView.swift
//  Swift-Learning-App
//
//  Created by Corbin Gollaher on 8/21/22.
//

import SwiftUI

struct HourlyCardScrollingView: View {
    var weatherList : [WeatherList]?
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                ForEach(weatherList ?? [], id: \.dt) { weather in
                    NavigationLink(destination: HourlyForecastDetailView(weather: weather)) {
                        HourlyCardView(icon: getIconString(code: weather.weather.first?.id ?? 0), day: getTimeFromUTC(utc: weather.dt), date: getDateFromUTC(utc: weather.dt), temp: Int(weather.main.temp))
                    }.navigationBarHidden(true)
                }.padding(.top, 15).padding(.bottom, 10).padding(.leading, 3).padding(.trailing, 3)
                    .symbolVariant(.fill)
                    .foregroundColor(.white)

            }
        }
    }
}

struct HourlyCardScrollingView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyCardScrollingView()
    }
}

//
//  SwiftUIView.swift
//  Swift-Learning-App
//
//  Created by Corbin Gollaher on 8/21/22.
//

import SwiftUI

struct FiveDayForecastView: View {
    var weatherList: [WeatherList]?

    var body: some View {
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
            ForEach(weatherList ?? [], id: \.dt) { weather in
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

    }
}
struct FiveDayForecastView_Previews: PreviewProvider {
    static var previews: some View {
        FiveDayForecastView()
    }
}

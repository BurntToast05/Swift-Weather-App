//
//  DayInfoView.swift
//  Swift-Learning-App
//
//  Created by Corbin Gollaher on 8/20/22.
//

import SwiftUI

//
//  DetailView.swift
//  Swift-Learning-App
//
//  Created by Corbin Gollaher on 8/18/22.
//

import SwiftUI

struct CurrentForecastInfoView: View {
    var weather: CurrentWeatherResponse?

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
                    CurrentForecastInfoGrid(weather: weather).padding(.top, 10)
                    Spacer()
                }
            }
        }.navigationBarTitleDisplayMode(.inline)
    }
}

struct DayInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentForecastInfoView()
    }
}

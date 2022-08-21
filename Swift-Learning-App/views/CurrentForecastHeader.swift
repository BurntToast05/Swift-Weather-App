//
//  CurrentForecastHeader.swift
//  Swift-Learning-App
//
//  Created by Corbin Gollaher on 8/21/22.
//

import SwiftUI

struct CurrentForecastHeader: View {
    var weatherController: WeatherController?
    var body: some View {
        Text(weatherController?.userTown ?? "")
            .font(.system(size: 28))
            .foregroundColor(Color.white)
            .fontWeight(.semibold).padding(.top, 15)
        Image(systemName: getIconString(code: weatherController?.weather?.weather.first?.id ?? 1000)).renderingMode(.original).resizable().aspectRatio(contentMode: .fit).frame(width: 120, height: 120, alignment: .center)
        Text("\(weatherController?.weather?.weather.first?.weatherDescription.capitalized ?? "")")
            .font(.system(size: 20))
            .foregroundColor(Color.white)
            .fontWeight(.semibold).multilineTextAlignment(.center)
        Text("\(String(Int(weatherController?.weather?.main.temp ?? 00)))°")
            .font(.system(size: 80))
            .foregroundColor(Color.white)
            .fontWeight(.semibold).multilineTextAlignment(.center)

        HStack { Text("High:\(String(Int(weatherController?.weather?.main.tempMax ?? 00)))°")
                .font(.system(size: 15))
                .foregroundColor(Color.white)
                .fontWeight(.semibold).multilineTextAlignment(.center)
            Text("Low: \(String(Int(weatherController?.weather?.main.tempMin ?? 00)))°")
                .font(.system(size: 15))
                .foregroundColor(Color.white)
                .fontWeight(.semibold).multilineTextAlignment(.center)
            Text("Feels Like: \(String(Int(weatherController?.weather?.main.feelsLike ?? 00)))°")
                .font(.system(size: 15))
                .foregroundColor(Color.white)
                .fontWeight(.semibold).multilineTextAlignment(.center)
        }
    }
}

struct CurrentForecastHeader_Previews: PreviewProvider {
    static var previews: some View {
        CurrentForecastHeader()
    }
}

//
//  HourlyCardView.swift
//  Swift-Learning-App
//
//  Created by Corbin Gollaher on 8/20/22.
//

import SwiftUI

struct HourlyCardView: View {
    var icon: String?
    var day: String?
    var date: String?
    var temp: Int?

    var body: some View {
        VStack(spacing: 0) {
            Text(date ?? "")
                .font(.system(size: 12))
                .foregroundColor(Color.white).multilineTextAlignment(.center)
            Text(day ?? "")
                .font(.system(size: 12))
                .foregroundColor(Color.white).multilineTextAlignment(.center)
            Image(systemName: icon ?? "").renderingMode(.original).resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50, alignment: .center).padding(3)
            Text("\(String(temp ?? 0))°")
                .font(.system(size: 25))
                .foregroundColor(Color.white).multilineTextAlignment(.center)
        }.padding(5).cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white, lineWidth: 2))
            .shadow(radius: 10)
    }
}

struct HourlyCardView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyCardView()
    }
}

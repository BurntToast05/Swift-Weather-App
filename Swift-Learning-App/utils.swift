//
//  utils.swift
//  Swift-Learning-App
//
//  Created by Corbin Gollaher on 8/20/22.
//

import Foundation

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

func compassDirection(heading: Double) -> String? {
    if heading < 0 { return nil }
    let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
    let index = Int((heading + 22.5) / 45.0) & 7
    return directions[index]
}

func getDateFromUTC(utc: Int) -> String
{
    let date = Date(timeIntervalSince1970: Double(utc))
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "MST") //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "M/d" //Specify your format that you want
    let strDate = dateFormatter.string(from: date)
    return strDate;
}
func getDayFromUTC(utc: Int) -> String
{
    let date = Date(timeIntervalSince1970: Double(utc))
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "MST") //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "EEEE" //Specify your format that you want
    let strDate = dateFormatter.string(from: date).capitalized
    return strDate;
}

func getTimeFromUTC(utc: Int) -> String
{
    let date = Date(timeIntervalSince1970: Double(utc))
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "MST") //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "h a" //Specify your format that you want
    dateFormatter.amSymbol = "AM"
    dateFormatter.pmSymbol = "PM"
    let strDate = dateFormatter.string(from: date)
    return strDate;
}

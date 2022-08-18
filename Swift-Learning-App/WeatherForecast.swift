// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct WeatherForecast: Codable {
    let cod: String
    let message, cnt: Int
    let list: [WeatherList]
    let city: Cities
}

// MARK: - City
struct Cities: Codable {
    let id: Int
    let name: String
    let coord: Coordinates
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - Coord
struct Coordinates: Codable {
    let lat, lon: Double
}

// MARK: - List
struct WeatherList: Codable {
    let dt: Int
    let main: MainClass
    let weather: [WeatherStuff]
    let clouds: CloudsForecast
    let wind: WindForecast
    let visibility: Int
    let pop: Double
    let rain: Rain?
}

// MARK: - Clouds
struct CloudsForecast: Codable {
    let all: Int
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct WeatherStuff: Codable {
    let id: Int
    let main: MainEnum
    let weatherDescription: Description
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
}

// MARK: - Wind
struct WindForecast: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}

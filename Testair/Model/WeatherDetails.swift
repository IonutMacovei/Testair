//
//  WeatherDetails.swift
//  Testair
//
//  Created by Ionut Macovei on 15.05.2022.
//

import Foundation

// MARK: - WeatherDetails
struct WeatherDetails: Codable, Identifiable {
    var id: Int

    let weather: [Weather]?
    let main: Main?
    let dt: Int?
    let name: String?

    var tempCelsius: Int {
        Int((main?.temp ?? 0) - 273.15)
    }

    var tempString: String {
        String(tempCelsius) + Constants.Strings.celsius
    }

    var date: String {
        dt?.monthDay ?? ""
    }

    var details: String? {
        weather?.first?.description
    }

    var iconUrl: String {
        guard let urlString = weather?.first?.icon else { return ""}
        return "http://openweathermap.org/img/wn/\(urlString)@2x.png"
    }
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let description, icon: String
}

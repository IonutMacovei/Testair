//
//  WeatherDetails.swift
//  Testair
//
//  Created by Ionut Macovei on 15.05.2022.
//

import Foundation

// MARK: - WeatherDetails
struct WeatherDetails: Codable {
    let weather: [Weather]?
    let main: Main?
    let dt: Int?
    let name: String?

    var tempCelsius: Int {
        Int((main?.temp ?? 0) - 273.15)
    }

    var date: String {
        dt?.monthDay ?? ""
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

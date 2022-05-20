//
//  HomeViewMock.swift
//  TestairTests
//
//  Created by Ionut Macovei on 20.05.2022.
//

import Foundation
@testable import Testair

struct HomeViewMock {
    static let wrongCity = "Some wrong city"

    static var weather: Weather {
        Weather(id: 803,
                description: "overcast clouds",
                icon: "some url")
    }

    static var main: Main {
        Main(temp: 291.44)
    }

    static var weatherDetails: WeatherDetails {
        WeatherDetails(id: 2950159,
                       weather: [weather],
                       main: main,
                       dt: 1653027327,
                       name: "Berlin")
    }

    static var weatherWrapper: WeatherWrapper {
        WeatherWrapper(id: 2950159,
                       name: "Berlin",
                       icon: "some url",
                       date: "Sat \n 12",
                       temperature: "21",
                       details: "overcast clouds")
    }

}

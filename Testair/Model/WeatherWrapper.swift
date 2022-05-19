//
//  WeatherWrapper.swift
//  Testair
//
//  Created by Ionut Macovei on 19.05.2022.
//

import Foundation

struct WeatherWrapper: Identifiable {
    var id: Int
    let name: String
    let icon: String
    let date: String
    let temperature: String
    let details: String
}

//
//  WeatherEndpoint.swift
//  Testair
//
//  Created by Ionut Macovei on 15.05.2022.
//

import Foundation
import Combine

enum WeatherEndpoint: Endpoint {

    case cityHandle(city: String)
    case weatherIcon(iconName: String)

    var route: String {
        switch self {
        case .cityHandle(let city):
            return "/data/2.5/weather?q=\(city)&appid=3d3dc9b067f0eb934f215ad3e0905a62"
        case .weatherIcon(let icon):
            return "/img/wn/\(icon)@2x.png"
        }
    }

    var httpMethod: HttpMethod {
        switch self {
        case .cityHandle, .weatherIcon:
            return .get
        }
    }
}

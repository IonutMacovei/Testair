//
//  ApiHelper.swift
//  Testair
//
//  Created by Ionut Macovei on 15.05.2022.
//

import Foundation

struct ApiHelper {
    enum ApiEnvironment {
        case dev
        case live

        static var environment: ApiEnvironment {
            #if DEBUG
            return .dev
            #else
            return .live
            #endif
        }
    }

    static var apiUrl: String {
        switch ApiEnvironment.environment {
        case .dev, .live:
            //since we've only got access to 1 url, for this demo it's gonna be
            //the same one for both sandbox and production endpoints
            return "http://api.openweathermap.org"
        }
    }
}

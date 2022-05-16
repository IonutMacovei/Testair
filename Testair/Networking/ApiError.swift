//
//  ApiError.swift
//  Testair
//
//  Created by Ionut Macovei on 15.05.2022.
//

import Foundation

enum ApiError: Swift.Error {
    case error(error: Error)
    case message(message: String)
    case invalidUrl
    case unknown

    var errorMessage: String {
        switch self {
        case .error(error: let error):
            return error.localizedDescription
        case .message(message: let message):
            return message
        case .invalidUrl:
            return "Invalid URL"
        case .unknown:
            return "Unknown error"
        }
    }
}

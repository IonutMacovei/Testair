//
//  Endpoint.swift
//  Testair
//
//  Created by Ionut Macovei on 15.05.2022.
//

import Foundation
import Combine

typealias JSONDictionary = [String: Any]

protocol Endpoint {
    var route: String { get }
    var httpMethod: HttpMethod { get }

    func request<T: Codable>(with service: NetworkInitiable) -> AnyPublisher<T, ApiError>
}

extension Endpoint {
    func request<T: Codable>(with service: NetworkInitiable) -> AnyPublisher<T, ApiError> {
        let urlPath = ApiHelper.apiUrl + route
        guard let url = URL(string: urlPath) else {
            return Future { promise in
                promise(.failure(ApiError.invalidUrl))
            }
            .eraseToAnyPublisher()
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue

        return service.requestPublisher(with: urlRequest)
    }
}


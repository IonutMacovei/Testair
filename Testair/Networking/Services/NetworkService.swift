//
//  NetworkService.swift
//  Testair
//
//  Created by Ionut Macovei on 15.05.2022.
//

import Foundation
import Combine

final class NetworkService: NetworkInitiable {

    static let shared = NetworkService()
    private init() {}

    func requestPublisher<T: Codable>(with request: URLRequest) -> AnyPublisher<T, ApiError> {
        URLSession.shared.dataTaskPublisher(for: request)
            //since url sessions tasks run on the background thread there's no need to explicitly subscribe on the background thread
            //.subscribe(on: DispatchQueue.global(qos: .background))
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError({ (error: Error) -> ApiError in
                return ApiError.error(error: error)
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

}

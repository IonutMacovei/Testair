//
//  NetworkInitiable.swift
//  Testair
//
//  Created by Ionut Macovei on 15.05.2022.
//

import Foundation
import Combine

protocol NetworkInitiable: AnyObject {
    func requestPublisher<T: Codable>(with request: URLRequest) -> AnyPublisher<T, ApiError>
}

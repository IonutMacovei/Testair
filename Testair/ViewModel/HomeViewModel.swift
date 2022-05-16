//
//  HomeViewModel.swift
//  Testair
//
//  Created by Ionut Macovei on 15.05.2022.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject, ViewModelInitiable {

    typealias ModelObject = Any?

    let webservice: NetworkInitiable

    @Published private(set) var error: ApiError?
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var weatherPublisher: WeatherDetails?

    var cancelables = Set<AnyCancellable>()

    required init(webservice: NetworkInitiable = NetworkService.shared,
                  with model: Any? = nil) {
        self.webservice = webservice
    }

    func retriveWeatherData(cityName: String) {
        guard !isLoading, !cityName.isEmpty else { return }
        isLoading = true

        WeatherEndpoint.cityHandle(city: cityName).request(with: webservice)
            .sink { [weak self] (completion: Subscribers.Completion<ApiError>) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.error = error
                    print(error)
                }
                self?.isLoading = false
            } receiveValue: { [weak self] (weather: WeatherDetails) in
                self?.weatherPublisher = weather
            }.store(in: &cancelables)
            
    }
}

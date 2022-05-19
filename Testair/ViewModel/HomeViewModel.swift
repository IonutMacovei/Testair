//
//  HomeViewModel.swift
//  Testair
//
//  Created by Ionut Macovei on 15.05.2022.
//

import Foundation
import Combine
import CoreData

final class HomeViewModel: ObservableObject, ViewModelInitiable {
    typealias ModelObject = Any?

    var weatherId: NSManagedObjectID?

    let webservice: NetworkInitiable
    let viewContext: NSManagedObjectContext

    @Published private(set) var error: ApiError?
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var weatherPublisher: WeatherDomain?

    var cancelables = Set<AnyCancellable>()

    required init(webservice: NetworkInitiable = NetworkService.shared,
                  with viewContext: NSManagedObjectContext) {
        self.webservice = webservice
        self.viewContext = viewContext
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
                }
                self?.isLoading = false
            } receiveValue: { [weak self] (weatherDetails: WeatherDetails) in
                self?.onReceiveValue(with: weatherDetails)
            }.store(in: &cancelables)
    }

    private func onReceiveValue(with weather: WeatherDetails) {
        let weatherDomain = WeatherDomain(name: weather.name ?? "",
                                          icon: weather.iconUrl,
                                          date: weather.date,
                                          temperature: weather.tempString,
                                          details: weather.details ?? "")

        saveWeather(weatherId: weatherId, with: weatherDomain, in: viewContext)
        weatherPublisher = weatherDomain
    }

    func saveWeather(weatherId: NSManagedObjectID?, with weatherDetails: WeatherDomain, in context: NSManagedObjectContext) {
        let weather: CityWeather
        if let objectId = weatherId,
            let fetchedWeather = fetchWeather(for: objectId, context: context) {
            weather = fetchedWeather
        } else {
            weather = CityWeather(context: context)
        }

        weather.name = weatherDetails.name
        weather.icon = weatherDetails.icon
        weather.date = weatherDetails.date
        weather.temperature = weatherDetails.temperature
        weather.details = weatherDetails.details
        weather.timeAdded = Date()
        do {
            try context.save()
        } catch {
            print("Save error: \(error)")
        }
    }

    func fetchWeatherHistory(in context: NSManagedObjectContext) -> [WeatherDomain] {
        let fetchRequest: NSFetchRequest<CityWeather>
        fetchRequest = CityWeather.fetchRequest()
        fetchRequest.fetchLimit = 5
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timeAdded", ascending: false)]
        var weatherDomains: [WeatherDomain] = []
        do {
            let objects = try context.fetch(fetchRequest)
            objects.forEach { cityWeather in
                weatherDomains.append(WeatherDomain(name: cityWeather.name ?? "",
                                                    icon: cityWeather.icon ?? "",
                                                    date: cityWeather.date ?? "",
                                                    temperature: cityWeather.temperature ?? "",
                                                    details: cityWeather.details ?? ""))
            }
        } catch {
            print("Error")
        }
        return weatherDomains
    }

    private func fetchWeather(for objectId: NSManagedObjectID, context: NSManagedObjectContext) -> CityWeather? {
        guard let weather = context.object(with: objectId) as? CityWeather else {
            return nil
        }

        return weather
    }
}


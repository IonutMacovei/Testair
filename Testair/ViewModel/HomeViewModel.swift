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

    let webservice: NetworkInitiable
    let viewContext: NSManagedObjectContext

    @Published private(set) var error: ApiError?
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var weatherPublisher: WeatherWrapper?

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

    func saveWeather(with weatherWrapper: WeatherWrapper, in context: NSManagedObjectContext) {
        var weather: CityWeather?
        checkBeforeSave(weatherWrapper, context, &weather)
        do {
            try context.save()
        } catch {
            print("Save error: \(error)")
        }
    }

    func fetchWeatherHistory(in context: NSManagedObjectContext) -> [WeatherWrapper] {
        let fetchRequest: NSFetchRequest<CityWeather>
        fetchRequest = CityWeather.fetchRequest()
        fetchRequest.fetchLimit = 5
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timeAdded", ascending: false)]
        var weatherWrappers: [WeatherWrapper] = []
        do {
            let objects = try context.fetch(fetchRequest)
            objects.forEach { cityWeather in
                weatherWrappers.append(WeatherWrapper(id: Int(cityWeather.id),
                                                      name: cityWeather.name ?? "",
                                                      icon: cityWeather.icon ?? "",
                                                      date: cityWeather.date ?? "",
                                                      temperature: cityWeather.temperature ?? "",
                                                      details: cityWeather.details ?? ""))
            }
        } catch {
            print("Error")
        }
        return weatherWrappers
    }

    private func onReceiveValue(with weather: WeatherDetails) {
        let weatherWrapper = WeatherWrapper(id: weather.id,
                                             name: weather.name ?? "",
                                             icon: weather.iconUrl,
                                             date: weather.date,
                                             temperature: weather.tempString,
                                             details: weather.details ?? "")

        saveWeather(with: weatherWrapper, in: viewContext)
        weatherPublisher = weatherWrapper
    }

    private func updateData(_ weather: CityWeather, _ weatherDetails: WeatherWrapper) {
        weather.id = Int64(weatherDetails.id)
        weather.name = weatherDetails.name
        weather.icon = weatherDetails.icon
        weather.date = weatherDetails.date
        weather.temperature = weatherDetails.temperature
        weather.details = weatherDetails.details
        weather.timeAdded = Date()
    }

    private func checkBeforeSave(_ weatherDetails: WeatherWrapper, _ context: NSManagedObjectContext, _ weather: inout CityWeather?) {
        let fetchRequest: NSFetchRequest<CityWeather>
        fetchRequest = CityWeather.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %i", weatherDetails.id)
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results {
                    updateData(result, weatherDetails)
                }
            } else {
                weather = CityWeather(context: context)
                if let weather = weather {
                    updateData(weather, weatherDetails)
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}

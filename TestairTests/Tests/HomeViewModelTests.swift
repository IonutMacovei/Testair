//
//  HomeViewModelTests.swift
//  TestairTests
//
//  Created by Ionut Macovei on 20.05.2022.
//

import XCTest
import Combine
@testable import Testair

final class HomeViewModelTests: XCTestCase {

    private var viewModel: HomeViewModel?
    private var cancellables = Set<AnyCancellable>()
    let persistentManager = PersistenceManager(inMemory: true)

    override func tearDown() {
        super.tearDown()
        viewModel = nil
        cancellables.removeAll()
    }

    func testFetchWeatherDataWithSuccess() {
        let viewContext = persistentManager.container.viewContext
        viewModel = HomeViewModel(webservice: MockService(result: .success(HomeViewMock.weatherDetails)), with: viewContext)
        guard let viewModel = viewModel else {
            XCTFail("viewModel should not be nil")
            return
        }

        viewModel.retriveWeatherData(cityName: HomeViewMock.weatherDetails.name ?? "")

        let exp = expectationFrom(publisher: viewModel.$weatherPublisher,
                                  cancellables: &cancellables) { (weather: WeatherWrapper?) in
            XCTAssertNotNil(weather)
        }
        wait(for: [exp], timeout: 0.5)
    }

    func testFetchWeatherDataWithError() {
        let viewContext = persistentManager.container.viewContext
        viewModel = HomeViewModel(webservice: MockService(result: .success(HomeViewMock.weatherDetails)), with: viewContext)
        guard let viewModel = viewModel else {
            XCTFail("viewModel should not be nil")
            return
        }

        viewModel.retriveWeatherData(cityName: HomeViewMock.wrongCity)

        let exp = expectationFrom(publisher: viewModel.$error,
                                  cancellables: &cancellables) { (error: ApiError?) in
            XCTAssertNotNil(error)
        }
        wait(for: [exp], timeout: 0.5)
    }

    func testFetchLocalDataWithSuccess() {
        let viewContext = persistentManager.container.viewContext
        viewModel = HomeViewModel(webservice: MockService(result: .success(HomeViewMock.weatherDetails)), with: viewContext)
        guard let viewModel = viewModel else {
            XCTFail("viewModel should not be nil")
            return
        }

        let history = viewModel.fetchWeatherHistory(in: viewContext)
        XCTAssertNotNil(history)
    }
}

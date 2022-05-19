//
//  HomeView.swift
//  Testair
//
//  Created by Ionut Macovei on 15.05.2022.
//

import SwiftUI
import CoreData

struct HomeView: View, ViewInitiable {
    @Environment(\.managedObjectContext) private var viewContext

    typealias ViewModel = HomeViewModel

    @ObservedObject var viewModel: ViewModel

    @State var text = ""
    @State var showSecondView = false
    @State var showHistory = false
    @State var history: [WeatherWrapper] = []

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            content
        }
    }

    private var content: some View {
        BackgroundView {
            Constants.gradient
        } content: {
            VStack(spacing: Constants.Layout.spacing) {
                Image(Images.logo)
                    .scaledToFit()
                inputField
                historyButton
                NavigationLink(destination: ResultsView(cities: history),
                               isActive: $showHistory) { }

                Unwrap(viewModel.weatherPublisher) { weather in
                    NavigationLink(destination: ResultsView(cities: [weather]),
                                   isActive: $showSecondView) { }
                }
            }
            .padding()
            .offset(x: 0, y: -64)
        }
    }

    private var inputField: some View {
        HStack {
            TextField(Constants.Strings.enterCityName.uppercased(), text: $text)
                .foregroundColor(.green)
                .font(Font.system(size: Constants.Layout.fontSize))
            Color.green.frame(width: Constants.Layout.inputSeparatorWidth,
                              height: Constants.Layout.inputSeparatorHeight)
            inputButton
        }
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(Constants.Layout.cornerRadius)
    }

    private var inputButton: some View {
        Button(action: {
            if !viewModel.isLoading  {
                viewModel.retriveWeatherData(cityName: text)
                showSecondView = true
            }
        }) {
            Image(Images.arrow)
                .renderingMode(.template)
                .scaledToFit()
                .foregroundColor(.green)
        }
    }

    private var historyButton: some View {
        Button(action: {
            history = viewModel.fetchWeatherHistory(in: viewContext)
            if !history.isEmpty, !viewModel.isLoading {
                showHistory = true
            } else {
                // TODO: We need to show an alert to inform the user that he has no weather history
            }
        }) {
            Text(Constants.Strings.viewHistory.uppercased())
                .font(.system(size: Constants.Layout.fontSize))
                .padding(.horizontal, Constants.Layout.horizontalPadding)
                .padding(.vertical)
                .foregroundColor(.white)
        }
        .background(Color.white.opacity(Constants.Layout.alpha))
        .cornerRadius(Constants.Layout.cornerRadius)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: .init(webservice: MockService(result: .success(EmptyResponse())),
                                  with: NSManagedObjectContext(.privateQueue)))
    }
}

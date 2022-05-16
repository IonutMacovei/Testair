//
//  HomeView.swift
//  Testair
//
//  Created by Ionut Macovei on 15.05.2022.
//

import SwiftUI

struct HomeView: View, ViewInitiable {

    typealias ViewModel = HomeViewModel

    @ObservedObject var viewModel: ViewModel

    @State var text = ""
    @State var showSecondView = false

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
                Unwrap(viewModel.weatherPublisher) { weather in
                    NavigationLink(destination: ResultsView(cities: [weather]), isActive: $showSecondView) { }
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
            Button(action: {
                showSecondView.toggle()
                viewModel.retriveWeatherData(cityName: text)
            }) {
                Image(Images.arrow)
                    .renderingMode(.template)
                    .scaledToFit()
                    .foregroundColor(.green)
            }
        }
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(Constants.Layout.cornerRadius)
    }

    private var historyButton: some View {
        Button(action: {
            print("view history tapped")
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
        HomeView(viewModel: .init(webservice: MockService(result: .success(EmptyResponse()))))
    }
}

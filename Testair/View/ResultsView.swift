//
//  ResultsView.swift
//  Testair
//
//  Created by Ionut Macovei on 16.05.2022.
//

import SwiftUI

struct ResultsView: View {
    var cities: [WeatherDetails]

    var body: some View {
        BackgroundView { } content: {
            list
        }
    }

    @ViewBuilder
    private var list: some View {
        List {
            ForEach(cities) { city in
                CityWeatherView(weatherDetails: city)
            }
            .listRowBackground(Color.white.opacity(Constants.Layout.alpha))
            .listRowInsets(rowInsets)
        }
        .background(Constants.gradient)
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
        }
    }

    private var rowInsets: EdgeInsets {
        return EdgeInsets(
            top: .zero,
            leading: .zero,
            bottom: .zero,
            trailing: .zero)
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(cities: [])
    }
}

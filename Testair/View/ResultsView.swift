//
//  ResultsView.swift
//  Testair
//
//  Created by Ionut Macovei on 16.05.2022.
//

import SwiftUI

struct ResultsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var cities: [WeatherDomain]

    var body: some View {
        BackgroundView { } content: {
            list
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }

    private var btnBack : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(Images.arrow)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .rotationEffect(.radians(.pi))
            }
        }
    }

    @ViewBuilder
    private var list: some View {
        List {
            ForEach(cities, id: \.self) { city in
                VStack {
                    CityWeatherView(weather: city)
                        .background(Color.white.opacity(Constants.Layout.alpha))
                        .cornerRadius(Constants.Layout.cornerRadius)
                    Spacer()
                }
            }
            .listRowBackground(Color.clear)
            .listRowInsets(rowInsets)
        }
        .background(Constants.gradient)
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
            UITableView.appearance().separatorColor = .clear
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

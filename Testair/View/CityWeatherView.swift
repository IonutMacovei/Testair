//
//  CityWeatherView.swift
//  Testair
//
//  Created by Ionut Macovei on 16.05.2022.
//

import SwiftUI
import Kingfisher

struct CityWeatherView: View {
    var weather: WeatherWrapper

    var body: some View {
        BackgroundView {
        } content: {
            content
        }
    }

    private var content: some View {
        VStack(alignment: .leading, spacing: .zero) {
            weatherCondition
            weatherData
        }
        .frame(maxWidth: .infinity)
        .padding(Constants.Layout.stackPadding)
    }

    private var weatherCondition: some View {
        HStack {
            KFImage(URL(string: weather.icon))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Constants.Layout.imageSize, height: Constants.Layout.imageSize)

            Unwrap(weather.details) { details in
                Text(details.capitalized)
                    .foregroundColor(.white)
            }
            Spacer()
        }
    }

    private var weatherData: some View {
        HStack(alignment: .bottom) {
            Unwrap(weather.name) { name in
                Text(name)
                    .foregroundColor(.white)
            }
            Spacer()
            Text(weather.temperature)
                .foregroundColor(.white)
                .font(.system(size: Constants.Layout.largeFontSize))
            Spacer()
            Text(weather.date)
                .foregroundColor(.white)
        }
    }
 }

struct CityWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CityWeatherView(weather: WeatherWrapper(id: 0, name: "", icon: "", date: "", temperature: "", details: ""))
            .previewLayout(.fixed(width: 400, height: 200))
            .colorScheme(.light)
            .previewDisplayName("Dark preview")
    }
}

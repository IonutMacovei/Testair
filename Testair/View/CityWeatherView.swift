//
//  CityWeatherView.swift
//  Testair
//
//  Created by Ionut Macovei on 16.05.2022.
//

import SwiftUI
import Kingfisher

struct CityWeatherView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var weatherDetails: WeatherDetails

    var body: some View {
        BackgroundView {
        } content: {
            content
        }
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

    private var content: some View {
        VStack(alignment: .leading, spacing: .zero) {
            weatherCondition
            weatherData
        }
        .frame(maxWidth: .infinity)
        .padding(Constants.Layout.stackPadding)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }

    private var weatherCondition: some View {
        HStack {
            KFImage(URL(string: weatherDetails.iconUrl))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Constants.Layout.imageSize, height: Constants.Layout.imageSize)

            Unwrap(weatherDetails.details) { details in
                Text(details.capitalized)
                    .foregroundColor(.white)
            }
            Spacer()
        }
    }

    private var weatherData: some View {
        HStack(alignment: .bottom) {
            Unwrap(weatherDetails.name) { name in
                Text(name)
                    .foregroundColor(.white)
            }
            Spacer()
            Text(weatherDetails.tempString)
                .foregroundColor(.white)
                .font(.system(size: Constants.Layout.largeFontSize))
            Spacer()
            Text(weatherDetails.date)
                .foregroundColor(.white)
        }
    }
 }

struct CityWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CityWeatherView(weatherDetails: WeatherDetails(id: 2, weather: nil, main: nil, dt: nil, name: nil))
            .previewLayout(.fixed(width: 400, height: 200))
            .colorScheme(.light)
            .previewDisplayName("Dark preview")
    }
}

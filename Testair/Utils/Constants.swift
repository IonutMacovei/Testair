//
//  Constants.swift
//  Testair
//
//  Created by Ionut Macovei on 15.05.2022.
//

import Foundation
import UIKit
import SwiftUI

struct Constants {
    static let gradient = LinearGradient(gradient: Gradient(colors: [Color("green"), Color("yellow")]),
                                  startPoint: .top,
                                  endPoint: .bottom)
    struct Strings {
        static let enterCityName = "Enter city name"
        static let viewHistory = "View history"
        static let celsius = "°"
    }

    struct Layout {
        static let cornerRadius: CGFloat = 12
        static let spacing: CGFloat = 24
        static let alpha: Double = 0.25
        static let horizontalPadding: CGFloat = 50
        static let stackPadding: CGFloat = 8
        static let inputSeparatorHeight: CGFloat = 45
        static let inputSeparatorWidth: CGFloat = 3
        static let imageSize: CGFloat = 35
        static let fontSize: CGFloat = 14
        static let largeFontSize: CGFloat = 100
    }
}

struct Images {
    static let logo = "Logo"
    static let arrow = "Arrow"
}

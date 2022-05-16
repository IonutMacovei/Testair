//
//  ViewInitiable.swift
//  Testair
//
//  Created by Ionut Macovei on 15.05.2022.
//

import Foundation
import SwiftUI

protocol ViewInitiable {
    associatedtype ViewModel: ObservableObject & ViewModelInitiable

    var viewModel: ViewModel { get set }
}



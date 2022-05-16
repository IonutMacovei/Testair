//
//  ViewModelInitiable.swift
//  Testair
//
//  Created by Ionut Macovei on 15.05.2022.
//

import Foundation
import Combine

protocol ViewModelInitiable: AnyObject {

    associatedtype ModelObject

    var webservice: NetworkInitiable { get }
    var cancelables: Set<AnyCancellable> { get }

    init(webservice: NetworkInitiable, with model: ModelObject)
}

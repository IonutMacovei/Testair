//
//  Unwrap.swift
//  Testair
//
//  Created by Ionut Macovei on 16.05.2022.
//

import SwiftUI

struct Unwrap<Value, Content: View>: View {
    private let value: Value?
    private let contentProvider: (Value) -> Content

    init(_ value: Value?,
         @ViewBuilder content: @escaping (Value) -> Content) {
        self.value = value
        contentProvider = content
    }

    var body: some View {
        value.map(contentProvider)
    }
}

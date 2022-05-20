//
//  TestCase+Expectation.swift
//  TestairTests
//
//  Created by Ionut Macovei on 20.05.2022.
//

import XCTest
import Combine

extension XCTestCase {
    func expectationFrom<T: Publisher>(
        publisher: T?,
        cancellables: inout Set<AnyCancellable>,
        onReceiveValue: @escaping (T.Output) -> () = { _ in }
    ) -> XCTestExpectation where T.Failure == Never {
        let exp = expectation(description: "Expectation for publisher -> " + String(describing: publisher))

        publisher?.sink { (output: T.Output) in
            onReceiveValue(output)
            exp.fulfill()
        }.store(in: &cancellables)

        return exp
    }
}

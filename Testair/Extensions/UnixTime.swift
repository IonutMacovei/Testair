//
//  UnixTime.swift
//  Testair
//
//  Created by Ionut Macovei on 15.05.2022.
//

import Foundation

typealias UnixTime = Int

extension UnixTime {
    private func formatType(form: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = form
        return dateFormatter
    }
    var dateFull: Date {
        return Date(timeIntervalSince1970: Double(self))
    }
    var month: String {
        return formatType(form: "MMM").string(from: dateFull)
    }

    var day: String {
        return formatType(form: "dd").string(from: dateFull)
    }

    var monthDay: String {
        return month.uppercased() + "\n  " + day
    }
}

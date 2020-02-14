//
//  DateFormatter+CustomFormat.swift
//  MusalaWeatherApp
//
//  Created by zdravko zdravkin on 2/12/20.
//  Copyright © 2020 zdravko zdravkin. All rights reserved.
//

import Foundation
import SDWebImage

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

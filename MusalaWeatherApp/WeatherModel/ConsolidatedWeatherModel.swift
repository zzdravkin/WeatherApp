//
//  ConsolidatedWeather.swift
//  MusalaWeatherApp
//
//  Created by zdravko zdravkin on 2/11/20.
//  Copyright © 2020 zdravko zdravkin. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class ConsolidatedWeatherModel: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var weatherStateName: String = ""
    @objc dynamic var weatherStateAbbr: String = ""
    @objc dynamic var windDirectionCompass: String = ""
    @objc dynamic var created: Date? = nil
    @objc dynamic var applicableDate: String? = ""
    @objc dynamic var minTemp: Float = 0
    @objc dynamic var maxTemp: Float = 0
    @objc dynamic var theTemp: Float = 0
    @objc dynamic var windSpeed: Double = 0
    @objc dynamic var windDirection: Double = 0
    @objc dynamic var airPressure: Double = 0
    @objc dynamic var humidity: Int = 0
    @objc dynamic var visibility: Double = 0
    @objc dynamic var predictability: Int = 0

    override static func primaryKey() -> String? {
        return "id"
    }
}

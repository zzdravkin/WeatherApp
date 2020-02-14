//
//  WoeidModel.swift
//  MusalaWeatherApp
//
//  Created by zdravko zdravkin on 2/12/20.
//  Copyright © 2020 zdravko zdravkin. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class CityModel: Object, Codable {
    @objc dynamic var title: String = ""
    @objc dynamic var woeid: Int = 0

    override static func primaryKey() -> String? {
        return "woeid"
    }
}

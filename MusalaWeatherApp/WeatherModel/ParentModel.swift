//
//  ParentModel.swift
//  MusalaWeatherApp
//
//  Created by zdravko zdravkin on 2/11/20.
//  Copyright © 2020 zdravko zdravkin. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class ParentModel: Object, Codable {
    @objc dynamic var title: String = ""
    @objc dynamic var locationType: String = ""
    @objc dynamic var woeid: Int = 0
    @objc dynamic var lattLong: String = ""

    override static func primaryKey() -> String? {
        return "woeid"
    }
}

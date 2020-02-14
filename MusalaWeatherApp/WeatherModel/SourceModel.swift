//
//  SourceModel.swift
//  MusalaWeatherApp
//
//  Created by zdravko zdravkin on 2/11/20.
//  Copyright © 2020 zdravko zdravkin. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class SourceModel: Object, Codable {
    @objc dynamic var title: String! = ""
    @objc dynamic var slug: String! = ""
    @objc dynamic var url: String! = ""
    @objc dynamic var crawlRate: Int = 0

    override static func primaryKey() -> String? {
        return "title"
    }
}

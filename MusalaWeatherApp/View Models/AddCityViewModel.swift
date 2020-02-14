//
//  AddCityViewModel.swift
//  MusalaWeatherApp
//
//  Created by zdravko zdravkin on 2/12/20.
//  Copyright © 2020 zdravko zdravkin. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class AddCityViewModel {
    func getCity() -> Results<CityModel> {
        let realm = try! Realm()
        return realm.objects(CityModel.self)
    }

    func addNewCity(_ woeid: Int) {
        WeatherAPI.shared.fetchOneCityData(withWoeid: woeid) { [weak self] newData in
            guard let self = self else { return }

            switch newData {
            case let .failure(error):
                debugPrint(error)
            case let .success(data):
                let realm = try! Realm()
                try! realm.write {
                    if self.cityAlreadyAdded(newData: data) {
                    } else {
                        realm.create(WeatherModel.self, value: data, update: .modified)
                    }
                }
            }
        }
    }

    func cityAlreadyAdded(newData: WeatherModel) -> Bool {
        let realm = try! Realm()
        return realm.objects(WeatherModel.self).contains(newData)
    }
}

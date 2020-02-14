//
//  CityViewModel.swift
//  MusalaWeatherApp
//
//  Created by zdravko zdravkin on 2/12/20.
//  Copyright © 2020 zdravko zdravkin. All rights reserved.
//

import Foundation
import RealmSwift

class CityViewModel {
    var notificationToken: NotificationToken?
    let realm = try! Realm()
    
    init() {
        defaultDataForDB()
    }
    
    func setDefaultRealm() {
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("default.realm")
        Realm.Configuration.defaultConfiguration = config
    }
    
    // When RealmDB is changed send completion alert to VC to update tableView
    func monitorDBChanges(completion: @escaping () -> Void) {
        let results = realm.objects(CityModel.self)
        
        notificationToken = results.observe { (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                completion()
            case .update:
                completion()
            case let .error(error):
                fatalError("\(error)")
            }
        }
    }
    
    func defaultDataForDB() {
        let jsonData = Bundle.main.decode([CityModel].self, from: "Cities.json")
        for city in jsonData {
            // Insert from Data containing JSON
            try! realm.write {
                realm.create(CityModel.self, value: city, update: .modified)
            }
        }
    }
    
    func getCityData() -> Results<CityModel> {
        return realm.objects(CityModel.self)
    }
    
    // Validate the WOEID entered from the user
    func addNewCity(_ woeid: Int, fail: @escaping (String) -> Void) {
        WeatherAPI.shared.fetchOneCityData(withWoeid: woeid) { newData in
            switch newData {
            case let .failure(error):
                debugPrint(error)
                fail(error.localizedDescription)
            case let .success(data):
                // No completion needed as we have Listener that will be notified of the new city added in DB - monitorDBChanges
                let realm = try! Realm()
                try! realm.write {
                    realm.create(CityModel.self, value: data, update: .all)
                }
            }
        }
    }
    
    func checkIfDataIsAdded(woeid: Int) -> Bool {
        let results = realm.objects(WeatherModel.self)
        return (results.first {
            $0.woeid == woeid
            } != nil)
    }
}

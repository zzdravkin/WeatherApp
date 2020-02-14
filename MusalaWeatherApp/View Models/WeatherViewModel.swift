//
//  WeatherViewModel.swift
//  MusalaWeatherApp
//
//  Created by zdravko zdravkin on 2/11/20.
//  Copyright © 2020 zdravko zdravkin. All rights reserved.
//

import Foundation
import RealmSwift

class WeatherViewModel {
    func fetchPrimaryData(_ id: Int, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        guard NetworkMonitor.shared.isConnected() else {
            if let weatherData = getLastWeatherData() {
                completion(.success(weatherData))
                return
            }
            completion(.failure(NetworkError.serverError("No Data ever fetched.")))
            return
        }
        
        WeatherAPI.shared.fetchOneCityData(withWoeid: id) { result in
            switch result {
            case .success(let weatherData):
                let realm = try! Realm()
                try! realm.write {
                    realm.create(WeatherModel.self, value: weatherData, update: .all)
                }
                completion(.success(weatherData))
            case .failure(let error):
                completion(.failure(NetworkError.serverError(error.localizedDescription)))
            }
        }
    }

    func getLastWeatherData() -> WeatherModel? {
        let realm = try! Realm()
        guard let weatherModel = realm.objects(WeatherModel.self).last else {
            return nil
        }
        
        return weatherModel
    }
}

//
//  API.swift
//  MusalaWeatherApp
//
//  Created by zdravko zdravkin on 2/10/20.
//  Copyright © 2020 zdravko zdravkin. All rights reserved.
//

import Foundation

struct WeatherAPI {
    private init() {}
    static let shared = WeatherAPI()
    
    // Create background queue
    let queue = DispatchQueue.global(qos: .background)
    
    typealias serverResponse = Result<WeatherModel, Error>
    
    var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.metaweather.com"
        return urlComponents
    }
    
    func fetchOneCityData(withWoeid: Int, completion: @escaping (serverResponse) -> Void) {
        fetch(resources: withWoeid, completion: completion)
    }
    
    private func fetch(resources: Int, completion: @escaping (serverResponse) -> Void) {
        var urlComponents = self.urlComponents
        urlComponents.path = "/api/location/\(resources)"
        
        guard let url = urlComponents.url else {
            completion(.failure(NetworkError.badURL))
            return
        }
        
        queue.async {
            let urlSession = URLSession.shared
            urlSession.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.serverError(error?.localizedDescription ?? "General Error")))
                    }
                    return
                }
                
                guard let mime = response?.mimeType, mime == "application/json" else {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.mimeTypeError))
                    }
                    return
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                        
                        let json = try decoder.decode(WeatherModel.self, from: data)
                        
                        DispatchQueue.main.async {
                            completion(.success(json))
                        }
                    } catch {
                        debugPrint("error: \(error.localizedDescription)")
                        DispatchQueue.main.async {
                            completion(.failure(NetworkError.jsonParse(error.localizedDescription)))
                        }
                    }
                }
            }.resume()
        }
    }
}

//
//  Extensions.swift
//  MusalaWeatherApp
//
//  Created by zdravko zdravkin on 2/11/20.
//  Copyright © 2020 zdravko zdravkin. All rights reserved.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String,
                              dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                              keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch let DecodingError.keyNotFound(key, context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch let DecodingError.typeMismatch(_, context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch let DecodingError.valueNotFound(type, context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
    
    func decodeFromData<T: Decodable>(_ type: T.Type, from data: Data,
                                      dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                      keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> Result<T, NetworkError> {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy
        
        do {
            let test = try decoder.decode(T.self, from: data)
            return Result.success(test)
            
            
        } catch let DecodingError.keyNotFound(key, context) {
            return Result.failure(NetworkError.jsonParse("Failed to decode from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)"))
        } catch let DecodingError.typeMismatch(_, context) {
            return Result.failure(NetworkError.jsonParse("Failed to decode from bundle due to type mismatch – \(context.debugDescription)"))
        } catch let DecodingError.valueNotFound(type, context) {
            return Result.failure(NetworkError.jsonParse("Failed to decode from bundle due to missing \(type) value – \(context.debugDescription)"))
        } catch DecodingError.dataCorrupted(_) {
            return Result.failure(NetworkError.jsonParse("Failed to decode  from bundle because it appears to be invalid JSON"))
        } catch {
            return Result.failure(NetworkError.jsonParse("Failed to decode from bundle: \(error.localizedDescription)"))
        }
    }
}

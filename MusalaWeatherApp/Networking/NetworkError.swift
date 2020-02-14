//
//  NetworkError.swift
//  MusalaWeatherApp
//
//  Created by zdravko zdravkin on 2/13/20.
//  Copyright © 2020 zdravko zdravkin. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case jsonParse(String)
    case serverError(String)
    case mimeTypeError
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "The URL is not valid."
        case .jsonParse(let description):
            return "JSON Parsing failed with error \(description)"
        case .serverError(let description):
            return "Server Error: \(description)"
        case .mimeTypeError:
            return "Wrong MIME Type data returned from server"
        }
    }
}

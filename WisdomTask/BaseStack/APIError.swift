//
//  APIError.swift
//  WorkerlyAgent(MVVM)
//
//  Created by  Keerthana G on 07/12/22.
//

import Foundation

struct ErrorConstants {
    struct ErrorTitles {
        static let noNetwork = "Network Error"
        static let serverError = "Server Error"
        static let jsonError = "Internal Error"
        static let badResponse = "Bad Response: Data not found"
        static let noTemps = "No Temps"
    }
    struct ErrorMessages {
        static let noNetwork = "No internet connection. Please check the network settings."
        static let serverError = "Service unavailable now."
        static let jsonError = "Parsing failed"
        static let emotionError = "Please select your feelings."
        static let badResponse = "Bad Response: Data not found"
        static let noTemps = "No Temps Available"
    }
}
enum APIError: Error {
    case noNetwork
    case serverError
    case jsonError
    case runtimeError(String)
    case badResponse(URLResponse)
    case noTemps
}
extension APIError {
    var errorTitle: String {
        switch self {
        case .noNetwork:
            return ErrorConstants.ErrorTitles.noNetwork
        case .serverError:
            return ErrorConstants.ErrorTitles.serverError
        case .jsonError:
            return ErrorConstants.ErrorTitles.jsonError
        case .runtimeError(let err):
            return err
        case .badResponse(_):
            return ErrorConstants.ErrorTitles.badResponse
        case .noTemps:
            return ErrorConstants.ErrorTitles.noTemps
        }
    }
    var errorMessage: String {
        switch self {
        case .noNetwork:
            return ErrorConstants.ErrorMessages.noNetwork
        case .serverError:
            return ErrorConstants.ErrorMessages.serverError
        case .jsonError:
            return ErrorConstants.ErrorMessages.jsonError
        case .runtimeError(let err):
            return err
        case .noTemps:
            return ErrorConstants.ErrorMessages.noTemps
        case .badResponse(_):
            return ErrorConstants.ErrorMessages.badResponse
        }
    }
}

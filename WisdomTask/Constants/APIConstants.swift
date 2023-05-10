//
//  APIConstants.swift
//  WisdomTask
//
//  Created by Raghava Dokala on 09/05/23.
//

import Foundation
struct APIConstants {
    static let defaultTimeOut: Double = 120.0

    static var baseUrl: String {
        get {
            return AppGateway.sharedInstance.appGatewayEndPoint()
        }
    }
}

extension APIConstants {
    static let list = "list?"
    static let image = "list?"
}

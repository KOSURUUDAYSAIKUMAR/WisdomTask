//
//  APIConstants.swift
//  WisdomTask
//
//  Created by KOSURU UDAY SAIKUMAR on 09/05/23.
//

import Foundation
typealias BoolCompletion = (_ success: Bool) -> Void

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

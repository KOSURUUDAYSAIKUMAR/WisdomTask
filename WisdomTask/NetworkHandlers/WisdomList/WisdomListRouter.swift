//
//  WisdomListRouter.swift
//  WisdomTask
//
//  Created by Raghava Dokala on 09/05/23.
//

import Foundation

enum TempsApiRouter {
    case list(page:String)
    case image(id:String)
}

extension TempsApiRouter: NetworkConfiguration {
    var method: HTTPMethod {
        switch self {
        case .list:
            return .get
        case .image:
            return .get
        }
    }
    var path: String? {
        switch self {
        case .list:
            return APIConstants.list
        case .image:
            return APIConstants.image
        }
    }
    var headers: [String : String]? {
        switch self {
        case .list, .image:
            return ["Content-Type":"application/json"]
        }
    }
    var bodyparameters: [String : Any]? {
        switch self {
        case .list(let page):
            return ["page":page,
                    "limit":"100"]
        case .image(let id):
            return ["id":id]
        }
    }
}


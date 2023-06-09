//
//  WisdomeListModel.swift
//  WisdomTask
//
//  Created by KOSURU UDAY SAIKUMAR on 09/05/23.
//

import Foundation
typealias WisdomList = [WisdomeModel]

class WisdomeModel: NSObject, Decodable {
    var id, author, url, download_url: String?

    enum CodingKeys: String, CodingKey {
        case id, author, url, download_url
    }
}


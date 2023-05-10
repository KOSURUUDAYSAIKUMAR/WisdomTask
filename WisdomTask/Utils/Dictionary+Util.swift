//
//  Dictionary+Util.swift
//  ZohoWorkerly
//
//  Created by Raghava Dokala on 02/07/20.
//  Copyright © 2020 Raghava Dokala. All rights reserved.
//

import Foundation

extension Dictionary {
    var queryString: String? {
        var output: String = ""
        for (key,value) in self {
            output +=  "\(key)=\(value)&"
        }
        let urlString = output.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? output
        output = String(urlString.dropLast())
        return output
    }
}

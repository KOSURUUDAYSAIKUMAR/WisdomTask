//
//  Network+Utils.swift
//  HappyBeing
//
//  Created by KOSURU UDAY SAIKUMAR on 4/22/20.
//  Copyright © 2020 KOSURU UDAY SAIKUMAR All rights reserved.
//

import Foundation

extension Reachability {
    public static func isNetwrokReachable() -> Bool {
        let connection = try? Reachability().connection
        if connection == .unavailable {
            return false
        }
        return true
    }
}

//
//  Network+Utils.swift
//  HappyBeing
//
//  Created by Raghava Dokala on 4/22/20.
//  Copyright © 2020 RaghavaNaidu All rights reserved.
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

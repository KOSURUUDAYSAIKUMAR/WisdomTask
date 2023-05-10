//
//  ZWObservers.swift
//  ZohoWorkerly
//
//  Created by Raghava Dokala on 20/07/22.
//  Copyright © 2022 Raghava Dokala. All rights reserved.
//

import Foundation

public extension Notification.Name {
    static let wisdomList = Notification.Name("RefreshWisdomListPage")
    static let reachabilityChanged = Notification.Name("reachabilityChanged")
    
    @available(*, unavailable, renamed: "Notification.Name.reachabilityChanged")
    static let ReachabilityChangedNotification = NSNotification.Name("ReachabilityChangedNotification")
}

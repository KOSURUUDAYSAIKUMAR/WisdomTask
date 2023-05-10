//
//  ZWObservers.swift
//  ZohoWorkerly
//
//  Created by KOSURU UDAY SAIKUMAR on 20/07/22.
//  Copyright © 2022 KOSURU UDAY SAIKUMAR. All rights reserved.
//

import Foundation

public extension Notification.Name {
    static let wisdomList = Notification.Name("RefreshWisdomListPage")
    static let reachabilityChanged = Notification.Name("reachabilityChanged")
    
    @available(*, unavailable, renamed: "Notification.Name.reachabilityChanged")
    static let ReachabilityChangedNotification = NSNotification.Name("ReachabilityChangedNotification")
}

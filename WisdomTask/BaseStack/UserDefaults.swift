//
//  UserDefaults.swift
//  WorkerlyAgent(MVVM)
//
//  Created by  Keerthana G on 07/12/22.
//

import Foundation
import UIKit

var ZWAUserDefaults = UserDefaults.standard
    let APPLICATION = UIApplication.shared
    let APP_DELEGATE = APPLICATION.delegate as! AppDelegate
    let SCENE_DELEGATE = SceneDelegate()
    var CLIENT_DETAILS = [CLIENT_CONSTS()]


struct CLIENT_CONSTS {
        var CLIENT_ID =  "1002.BJDDJGLUZ4AHD1Y2X1PMWIT0WP5F3J"//localzoho -> "1002.4DYLRPLL04HMLX1ZGF1H487QBP0JYA"
        var ZSSO_URL_SCHEME = "workerlyagent"
        var SCOPES = ["ZohoWorkerly.modules.ALL","ZohoWorkerly.setup.ALL","ZohoWorkerly.settings.unavailability.ALL"]
    }

struct ZWSetup{
    static let KEY_USER_OAUTH_TOKEN = "user_oauth_token"
    static var OAUTH_TOKEN: String {
        get {
            return ZWAUserDefaults.string(forKey: ZWSetup.KEY_USER_OAUTH_TOKEN) ?? ""
        }set {
            ZWAUserDefaults.set(newValue, forKey: ZWSetup.KEY_USER_OAUTH_TOKEN)
        }
    }
    static let USER_TEMP_ID = "user_temp_id"
    static var TEMP_ID: String {
        get {
            return ZWAUserDefaults.string(forKey: ZWSetup.USER_TEMP_ID) ?? ""
        }set {
            ZWAUserDefaults.set(newValue, forKey: ZWSetup.USER_TEMP_ID)
        }
    }
    static let ONB_DESCRIPTION = "Get to know the status of a job right at your fingertip!"
    static var descriptionLabel : String {
        get{
            return
            ZWAUserDefaults.string(forKey: ZWSetup.ONB_DESCRIPTION) ?? ""
        }set{
            ZWAUserDefaults.set(newValue, forKey: ZWSetup.ONB_DESCRIPTION)
        }
    }
}

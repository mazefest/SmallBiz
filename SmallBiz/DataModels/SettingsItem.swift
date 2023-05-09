//
//  SettingsItem.swift
//  SmallBiz
//
//  Created by Colby Mehmen on 5/3/23.
//

import Foundation

struct SettingsItem {
    var settingTitle: String
    var isActive: Bool
    var type: SettingsCellType
    
    mutating func readDefaults() {
        let defaults = UserDefaults.standard
        self.isActive = defaults.bool(forKey: self.settingTitle)
    }
}

enum SettingsCellType {
    case toggleSwitch
    case disclousre
}

//
//  Settings.swift
//  HabbitManagement
//
//  Created by 강호성 on 2021/05/30.
//

import Foundation

struct Section {
    let title: String
    let options: [SettingsOptionType]
}

enum SettingsOptionType {
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
}

struct SettingsOption {
    let title: String
    let handler: (() -> Void)
}

struct SettingsSwitchOption {
    let title: String
    var isOn: Bool
    let handler: (() -> Void)
}

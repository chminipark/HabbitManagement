//
//  Settings.swift
//  HabbitManagement
//
//  Created by 강호성 on 2021/05/30.
//

import Foundation

struct Section {
    let title: String
    let options: [SettingsOption]
}

struct SettingsOption {
    let title: String
    let handler: (() -> Void)
}

//
//  UserSetting.swift
//  HerHack
//
//  Created by JohnC on 10/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import Foundation

final class UserSettings {
  
  private enum SettingKey: String {
    case uid, name
  }
    
  static var uid: String! {
    get {
      return UserDefaults.standard.string(forKey: SettingKey.uid.rawValue)
    }
    set {
      if let value = newValue {
        UserDefaults.standard.set(value, forKey: SettingKey.uid.rawValue)
      } else {
        UserDefaults.standard.removeObject(forKey: SettingKey.uid.rawValue)
      }
    }
  }
    
  static var name: String! {
    get {
      return UserDefaults.standard.string(forKey: SettingKey.name.rawValue)
    }
    set {
      if let value = newValue {
        UserDefaults.standard.set(value, forKey: SettingKey.name.rawValue)
      } else {
        UserDefaults.standard.removeObject(forKey: SettingKey.name.rawValue)
      }
    }
  }
}

//
//  UserDefaults.swift
//  BrackIt
//
//  Created by Justin Galang on 6/14/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

extension DefaultsKeys {
    var username: DefaultsKey<String?> { return .init("username") }
    var launchCount: DefaultsKey<Int> { return .init("launchCount", defaultValue: 0) }
}

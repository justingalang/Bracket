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
    var creationNumberOfOptions: DefaultsKey<Int?> { return .init("creationNumberOfOptions", defaultValue: 2) }
}

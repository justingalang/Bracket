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
	
	//User
	var userID: DefaultsKey<String> { return .init("userID", defaultValue: " ")}
	
	//Tournament Creation
	var creationTournamentTopic: DefaultsKey<String> { return .init("creationTournamentTopic", defaultValue: " ")}
	var creationTournamentTitle: DefaultsKey<String> { return .init("creationTournamentTitle", defaultValue: " ")}
    var creationTournamentSize: DefaultsKey<Int?> { return .init("creationNumberOfOptions", defaultValue: 2) }
	var creationTournamentOptionsArray: DefaultsKey<[String]> { return .init("creationTournamentOptionsArray", defaultValue: [])}
	
	
}

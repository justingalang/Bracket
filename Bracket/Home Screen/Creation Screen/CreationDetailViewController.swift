//
//  CreationDetailViewController.swift
//  Bracket
//
//  Created by Justin Galang on 7/22/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit
import iOSDropDown

class CreationDetailViewController: UIViewController {
	
	@IBOutlet weak var topicSelector: DropDown!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		topicSelector.optionArray = ["Music", "Movie", "Book", "Game", "Online", "Celeb", "Other"]
	}
	
	
		
	
	
	
	

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

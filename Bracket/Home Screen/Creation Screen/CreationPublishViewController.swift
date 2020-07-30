//
//  CreationPublishViewController.swift
//  Bracket
//
//  Created by Justin Galang on 7/26/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
class CreationPublishViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
	
	@IBOutlet weak var tournamentTitle: UILabel!
	@IBOutlet weak var author: UILabel!
	@IBOutlet weak var optionPreview: UITableView!
	
	@IBOutlet weak var tournamentPicture: UIImageView!
	@IBOutlet weak var descriptionTextField: UITextField!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.tournamentTitle.text = Defaults.creationTournamentTitle

		optionPreview.delegate = self
		optionPreview.dataSource = self
		optionPreview.rowHeight = UITableView.automaticDimension
		optionPreview.estimatedRowHeight = 100.0
		

        // Do any additional setup after loading the view.
    }
    
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (Defaults.creationTournamentSize ?? 2)/2
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: PreviewCell.identifier) as! PreviewCell
		cell.setOptions(optionOneText: Defaults.creationTournamentOptionsArray[2*indexPath.row], optionTwoText: Defaults.creationTournamentOptionsArray[2*indexPath.row + 1])
		return cell
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

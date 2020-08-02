//
//  CreationPublishViewController.swift
//  Bracket
//
//  Created by Justin Galang on 7/26/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
class CreationPublishViewController: UIViewController {
	
	//@IBOutlet weak var tournamentTitle: UILabel!
	@IBOutlet weak var topic: UILabel!
	@IBOutlet weak var author: UILabel!
	@IBOutlet weak var authorImage: UIImageView!
	@IBOutlet weak var previewSize: UILabel!
	@IBOutlet weak var optionPreview: UITableView!
	
	@IBOutlet weak var tournamentPicture: UIImageView!
	@IBOutlet weak var descriptionTextView: UITextView!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setUI()
		

        // Do any additional setup after loading the view.
    }
	
	func setUI() {
		self.title = Defaults.creationTournamentTitle
		if Defaults.creationTournamentTopic == "" || Defaults.creationTournamentTopic == "None" {
			topic.text = ""
		} else {
			topic.text = Defaults.creationTournamentTopic
		}
		previewSize.text = "Tournament Preview: \(Defaults.creationTournamentSize ?? 0)"
		
		descriptionTextView.delegate = self
		descriptionTextView.text = "Write a description..."
		descriptionTextView.textColor = .lightGray
		optionPreview.delegate = self
		optionPreview.dataSource = self
		optionPreview.rowHeight = UITableView.automaticDimension
		optionPreview.estimatedRowHeight = 100.0
	}
	
	@IBAction func didPressPublish(_ sender: Any) {
		
	}
	
	
}

extension CreationPublishViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (Defaults.creationTournamentSize ?? 2)/2
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: PreviewCell.identifier) as! PreviewCell
		cell.setOptions(optionOneText: Defaults.creationTournamentOptionsArray[2*indexPath.row], optionTwoText: Defaults.creationTournamentOptionsArray[2*indexPath.row + 1])
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50
	}
}

extension CreationPublishViewController: UITextViewDelegate {
	func textViewDidBeginEditing(_ textView: UITextView)
	{
		if (textView.text == "Write a description..." && textView.textColor == .lightGray)
		{
			textView.text = ""
			textView.textColor = .black
		}
		textView.becomeFirstResponder() //Optional
	}

	func textViewDidEndEditing(_ textView: UITextView)
	{
		if (textView.text == "")
		{
			textView.text = "Write a description..."
			textView.textColor = .lightGray
		}
		textView.resignFirstResponder()
	}
}

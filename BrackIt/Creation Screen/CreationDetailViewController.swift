//
//  CreationDetailViewController.swift
//  BrackIt
//
//  Created by Justin Galang on 5/28/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit

class CreationDetailViewController: UIViewController {
	@IBOutlet weak var titleInputField: UITextField!
	@IBOutlet weak var sizeField: UITextField!
	@IBOutlet weak var setOptionView: UIView!
	
	struct Cell {
		static let previewCell = "PreviewCell"
	}
	let tournamentSizes = ["2", "4", "8", "16", "32", "64", "128"]
	var selectedSize: String?
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		createSizePicker()
		createToolbar()
    }
	
	
	/// Creates Picker View
	func createSizePicker() {
		let sizePicker = UIPickerView()
		sizePicker.delegate = self
		sizeField.inputView = sizePicker
		
		sizePicker.backgroundColor = .white
	}
	
	/// Create Tool Bar
	func createToolbar() {
		let toolBar = UIToolbar()
		toolBar.sizeToFit()
		
		toolBar.barTintColor = .white
		toolBar.tintColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
		
		let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(CreationDetailViewController.dismissKeyboard))
		
		toolBar.setItems([doneButton], animated: false)
		toolBar.isUserInteractionEnabled = true
		
		sizeField.inputAccessoryView = toolBar
	}
	
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
}

extension CreationDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return tournamentSizes.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return tournamentSizes[row]
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		selectedSize = tournamentSizes[row]
		sizeField.text = selectedSize
	}
}

extension CreationDetailViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		if let tournamentSize = sizeField.text{
			return Int(tournamentSize) ?? 0
		} else {
			return 0
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Cell.previewCell) as! NodeCreationCell
		return cell
	}
	

	
}

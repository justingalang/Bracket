//
//  LoginViewController.swift
//  Bracket
//
//  Created by Justin Galang on 8/3/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

	@IBOutlet weak var userNameTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var errorLabel: UILabel!
	@IBOutlet weak var loginButton: UIButton!
	@IBOutlet weak var signUpButton: UIButton!
	override func viewDidLoad() {
        super.viewDidLoad()
		setUI()
        // Do any additional setup after loading the view.
    }
	
	func setUI() {
		//Error Label
		errorLabel.isHidden = true
		//Text Fields
		Utilities.styleTextField(userNameTextField)
		Utilities.styleTextField(passwordTextField)
		//Buttons
		loginButton.layer.cornerRadius = 10
		signUpButton.layer.cornerRadius = 10
		
	}
    
	@IBAction func unwindToLogin(_ sender: UIStoryboardSegue) {}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

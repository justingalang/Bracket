//
//  SignUpViewController.swift
//  Bracket
//
//  Created by Justin Galang on 8/3/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit


class SignUpViewController: UIViewController {
	
	@IBOutlet weak var firstNameTextField: UITextField!
	@IBOutlet weak var lastNameTextField: UITextField!
	@IBOutlet weak var userNameTextField: UITextField!
	@IBOutlet weak var userNameErrorLabel: UILabel!
	
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var confirmPasswordTextField: UITextField!
	@IBOutlet weak var passwordErrorLabel: UILabel!
	
	@IBOutlet weak var birthDateTextField: UITextField!
	@IBOutlet weak var genderTextField: UITextField!
	@IBOutlet weak var ethnicityTextField: UITextField!
	
	@IBOutlet weak var signInButton: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setUI()

    }
     
	func setUI() {
		signInButton.layer.cornerRadius = 10
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

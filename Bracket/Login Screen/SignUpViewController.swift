//
//  SignUpViewController.swift
//  Bracket
//
//  Created by Justin Galang on 8/3/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import SwiftyUserDefaults

class SignUpViewController: UIViewController {
	
	@IBOutlet weak var firstNameTextField: UITextField!
	@IBOutlet weak var lastNameTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
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
		userNameErrorLabel.alpha = 0
		passwordErrorLabel.alpha = 0
		signInButton.layer.cornerRadius = 10
	}
	
	func validateFields() -> String? {
		//Check all fields are filled in
		if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
			lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
			emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
			userNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
			passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" /*||
			confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""*/ {
				return "Please fill in all fields."
		}
		
		let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
		if !(Utilities.isPasswordValid(cleanedPassword)) {
			//Password does not meet requirements
			return "Please make sure that your password is at least 5 characters"
		}
		
		return nil
	}
	
	@IBAction func didPushSignIn(_ sender: Any) {
		let error = validateFields()
		
		if error != nil {
			// There's an error
			showError(error!)
		} else {
			//Create cleaned versions of data
			let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
			let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
			let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
			let userName = userNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
			let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
			
			Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
				// Check for error
				if error != nil {
					//There was an error creating user
					self.showError("Error creating user")
				} else {
					// User created successfully - store
					let db = Firestore.firestore()
					let userID = result!.user.uid
					db.collection("users").document(userID).setData(
						["firstName": firstName,
						 "lastName": lastName,
						 "userName": userName,
						 "uid": userID]) { (error) in
							if error != nil {
								//Show error message
								self.showError("Error saving user data")
							}
					}
					self.transitionToHome()
				}
			}
		}
	}
	
	func showError(_ message: String) {
		passwordErrorLabel.text = message
		passwordErrorLabel.alpha = 1
	}
	
	func transitionToHome() {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let mainTabBarController = storyboard.instantiateViewController(identifier: Constants.Storyboard.mainTabBarController)
		
		// This is to get the SceneDelegate object from your view controller
		// then call the change root view controller function to change to main tab bar
		(UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
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

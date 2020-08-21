//
//  LoginViewController.swift
//  Bracket
//
//  Created by Justin Galang on 8/3/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

	@IBOutlet weak var emailTextField: UITextField!
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
		Utilities.styleTextField(emailTextField)
		Utilities.styleTextField(passwordTextField)
		//Buttons
		loginButton.layer.cornerRadius = 10
		signUpButton.layer.cornerRadius = 10
		
	}
	
	@IBAction func didTapLogin(_ sender: Any) {
		let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
		let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
		
		Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
			if error != nil {
				self.errorLabel.text = error!.localizedDescription
				self.errorLabel.alpha = 1
			} else {
				self.transitionToHome()
			}
		}
	}
	
	func transitionToHome() {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let mainTabBarController = storyboard.instantiateViewController(identifier: Constants.Storyboard.mainTabBarController)
		
		(UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
	}
    
	@IBAction func unwindToLogin(_ sender: UIStoryboardSegue) {}


}

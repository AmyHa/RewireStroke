//
//  SignUpViewController.swift
//  RewireStroke
//
//  Created by Amy Ha on 22/09/2020.
//  Copyright © 2020 Amy Ha. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var firstNameTextField: CustomTextField!
    @IBOutlet weak var lastNameTextField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var forgottenPasswordLabel: UILabel!
    
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var showButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.applyStyle()
    }

    private func applyStyle() {
        
        // Set themed styling to items
        TextFields.setBorderTextField(firstNameTextField)
        TextFields.setBorderTextField(lastNameTextField)
        TextFields.setBorderTextField(emailTextField)
        TextFields.setBorderTextField(passwordTextField)
        Buttons.setBlueMainButton(signUpButton)
        
        // Set up text fields text
        signUpButton.setTitle("Sign Up", for: .normal)
        TextFields.setTitleLabel(firstNameTextField, "First name")
        TextFields.setTitleLabel(lastNameTextField, "Last name")
        TextFields.setTitleLabel(emailTextField, "Email")
        TextFields.setTitleLabel(passwordTextField, "Password")
        
        // Set up text fields left padding
        firstNameTextField.setLeftPaddingPoints(10)
        lastNameTextField.setLeftPaddingPoints(10)
        emailTextField.setLeftPaddingPoints(10)
        passwordTextField.setLeftPaddingPoints(10)
        
        // Set custom font sizes
        signUpButton.titleLabel?.font = UIFont.robotoBold(size: Constants.Font.Size.standard)
        signUpLabel.font = UIFont.rajdhaniSemiBold(size: Constants.Font.Size.large)
        forgottenPasswordLabel.font = UIFont.robotoBold(size: Constants.Font.Size.standard)
        
        // Set any additional colours
        loginButton.setTitleColor(Colours.primaryBlue, for: .normal)
        signUpLabel.textColor = Colours.primaryDark
        forgottenPasswordLabel.textColor = Colours.primaryBlue
            
        // Hide password when typing in for password field
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .password
        
        setUpShowButton()
        
        // Hide error label
        errorLabel.alpha = 0
    }
    
    // Programmatically add Show button in the password textfield
    private func setUpShowButton() {
        
        showButton = UIButton(type: .custom)
        showButton.setTitle("Show", for: .normal)
        showButton.titleLabel?.font = UIFont(name: Constants.Font.Name.robotoRegular, size: Constants.Font.Size.hintButton)
        showButton.setTitleColor(Colours.primaryBlue, for: .normal)
        showButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        passwordTextField.rightView = showButton
        passwordTextField.rightViewMode = .whileEditing
        
        showButton.addTarget(self, action: #selector(self.showButtonTapped), for: .touchDown)
    }
    
    // check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    private func validateFields() -> String? {
        
        // check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        return nil
    }
    
    func showError(error: String) {
        errorLabel.text = error
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        
        // programmatically set home VC as root VC
//        let welcomeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.welcomeViewController) as? WelcomeViewController
        view.window?.rootViewController = WelcomeViewController(collectionViewLayout: UICollectionViewFlowLayout())
        view.window?.makeKeyAndVisible()
    }

    // ACTIONS
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        // Validate fields
        let error = validateFields()
        
        if let err = error {
            // There is something wrong with the fields, show error message
            showError(error: err)
        } else {
            // create cleaned version of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // create user
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, err) in
                // check for errors
                if err != nil {
                    self.showError(error: "Error creating user")
                } else {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstName": firstName, "lastName": lastName, "uid": result!.user.uid, "numberOfLogins": 1]) { (error) in
                        if error != nil {
                            self.showError(error: "Error saving user data.")
                            print(error)
                        }
                    }
                    
                    // Transition to home screen
                    self.transitionToHome()
                }
            }
        }
        
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        // Navigate to
    }
    
    @objc func showButtonTapped() {
        
        // If the password text field is empty, return
        if passwordTextField.text == "" {
            return
        }
        
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        
        let buttonTitle = passwordTextField.isSecureTextEntry ? "Show" : "Hide"
        showButton.setTitle(buttonTitle, for: .normal)
    }
}

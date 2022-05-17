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
    
    var signUpViewModel = SignUpViewModel()
    
    @IBOutlet weak var firstNameTextField: CustomTextField!
    @IBOutlet weak var lastNameTextField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var signUpButton: GradientButton!
    @IBOutlet weak var forgottenPasswordLabel: UILabel!
    
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var showButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        
        self.applyStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
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
        signUpButton.titleLabel?.font = UIFont.outfitSemiBold(size: Constants.Font.Size.standard)
        signUpLabel.font = UIFont.outfitSemiBold(size: Constants.Font.Size.large)
        loginButton.titleLabel?.font = UIFont.outfitSemiBold(size: Constants.Font.Size.standard)
        loginButton.setTitleColor(Colours.primaryDark, for: .normal)
        forgottenPasswordLabel.font = UIFont.outfitBold(size: Constants.Font.Size.standard)
        
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
        showButton.titleLabel?.font = UIFont(name: Constants.Font.Name.outfitRegular, size: Constants.Font.Size.hintButton)
        showButton.setTitleColor(Colours.primaryBlue, for: .normal)
        showButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        passwordTextField.rightView = showButton
        passwordTextField.rightViewMode = .whileEditing
        showButton.addTarget(self, action: #selector(self.showButtonTapped), for: .touchDown)
    }
    
    func showError(error: String) {
        errorLabel.text = error
        errorLabel.alpha = 1
    }
    
    func transitionToWelcomePage() {
        
        // programmatically set home VC as root VC
        view.window?.rootViewController = WelcomeViewController(collectionViewLayout: UICollectionViewFlowLayout())
        view.window?.makeKeyAndVisible()
    }

    // ACTIONS
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text, var firstName = firstNameTextField.text, var lastName = lastNameTextField.text else { return }
        
        firstName = firstName.trimmingCharacters(in: .whitespacesAndNewlines)
        lastName = lastName.trimmingCharacters(in: .whitespacesAndNewlines)

        signUpViewModel.performSignUp(email: email, password: password, firstName: firstName, lastName: lastName) { error in
            
            if let error = error {
                switch error {
                case CredentialsError.emptyDetails:
                    self.showError(error: "Please fill in all details.")
                default:
                    print("Sign-up failed: \(error)")
                }
            } else {
                self.signUpViewModel.transitionToWelcomePage(view: self.view)
            }
        }
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
    
    @objc func handleTap() {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}

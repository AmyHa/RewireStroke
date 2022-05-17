//
//  ViewController.swift
//  RewireStroke
//
//  Created by Amy Ha on 22/09/2020.
//  Copyright © 2020 Amy Ha. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase
import FirebaseFirestoreSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgottenPasswordLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var showButton: UIButton!
    
    var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        TextFields.setBorderTextField(emailTextField)
        TextFields.setBorderTextField(passwordTextField)
        Buttons.setBlueMainButton(loginButton)
        
        // Set up text fields text
        loginButton.setTitle("Log In", for: .normal)
        TextFields.setTitleLabel(emailTextField, "Email")
        TextFields.setTitleLabel(passwordTextField, "Password")
        
        // Set up text fields left padding
        emailTextField.setLeftPaddingPoints(10)
        passwordTextField.setLeftPaddingPoints(10)
        
        // Set custom font sizes
        loginButton.titleLabel?.font = UIFont.outfitBold(size: Constants.Font.Size.standard)
        loginLabel.font = UIFont.outfitSemiBold(size: Constants.Font.Size.large)
        forgottenPasswordLabel.font = UIFont.outfitBold(size: Constants.Font.Size.standard)
        
        // Set any additional colours
        loginLabel.textColor = Colours.primaryDark
        forgottenPasswordLabel.textColor = Colours.primaryBlue
        
        // Hide password when typing in for password field
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .password
        
        setUpShowButton()
        setUpExitButton()
        
        // Hide error label
        errorLabel.alpha = 0
        
        // Set up placeholder text fields for testing
        emailTextField.text = "tomjerry@test.com"
        passwordTextField.text = "password"
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
    
    private func setUpExitButton() {
        let icon = UIImage(named: "close")!
        closeButton.tintColor = Colours.primaryDark
        closeButton.setImage(icon, for: .normal)
        closeButton.imageView?.contentMode = .scaleAspectFit
    }
    
    func showError(error: String) {
        errorLabel.text = error
        errorLabel.alpha = 1
    }
    
    
    // ACTIONS
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        
        // Exit the login page back to signup page
        navigationController?.popViewController(animated: true)
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
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
                
        loginViewModel.performLogin(email: email, password: password) { error in
            if let error = error {
                switch error {
                case CredentialsError.emptyDetails:
                    self.showError(error: "Please complete all fields.")

                default:
                    print("Unable to login: \(error)")
                }
            } else {
                self.loginViewModel.transitionToHome(view: self.view)
            }
        }
    }
    
    @objc func handleTap() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}


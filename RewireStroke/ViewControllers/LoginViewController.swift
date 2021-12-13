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
        
        self.applyStyle()
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
        loginButton.titleLabel?.font = UIFont.robotoBold(size: Constants.Font.Size.standard)
        loginLabel.font = UIFont.rajdhaniSemiBold(size: Constants.Font.Size.large)
        forgottenPasswordLabel.font = UIFont.robotoBold(size: Constants.Font.Size.standard)
        
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
        showButton.titleLabel?.font = UIFont(name: Constants.Font.Name.robotoRegular, size: Constants.Font.Size.hintButton)
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
    
    func transitionToHome() {
        
        // Since numberOfLogins > 0, then just transition to the homepage
        let homeViewController = HomeViewController.init(nibName: Constants.View.homeViewController, bundle: nil)
        let activityViewController = ActivityViewController.init(nibName: Constants.View.activityViewController, bundle: nil)
        let progressViewController = ProgressViewController.init(nibName: Constants.View.progressViewController, bundle: nil)
        let infoViewController = InfoViewController.init(nibName: Constants.View.infoViewController, bundle: nil)
        let profileViewController = ProfileViewController.init(nibName: Constants.View.profileViewController, bundle: nil)
        
        
        // tab bar icon
        let homeItem = UITabBarItem()
        homeItem.title = "Home"
        homeItem.image = UIImage(named: "iconHome")
        
        let activityItem = UITabBarItem()
        activityItem.title = "Activity"
        activityItem.image = UIImage(named: "iconActivity")

        let progressItem = UITabBarItem()
        progressItem.title = "Progress"
        progressItem.image = UIImage(named: "iconProgress")
        
        let infoItem = UITabBarItem()
        infoItem.title = "Info"
        infoItem.image = UIImage(named: "iconInfo")
        
        let profileItem = UITabBarItem()
        profileItem.title = "Profile"
        profileItem.image = UIImage(named: "iconProfile")
        
        homeViewController.tabBarItem = homeItem
        activityViewController.tabBarItem = activityItem
        progressViewController.tabBarItem = progressItem
        infoViewController.tabBarItem = infoItem
        profileViewController.tabBarItem = profileItem
        
        let tabBarController = UITabBarController()
        let controllers = [infoViewController, activityViewController, homeViewController, progressViewController, profileViewController]
        tabBarController.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
        
        tabBarController.selectedIndex = 2 // 2nd tab
        view.window?.rootViewController = tabBarController
        view.window?.makeKeyAndVisible()

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
        
        let userCredentials = UserCredentials(email: email, password: password)
        
        loginViewModel.performLogin(userCredentials) { error in
            if let error = error {
                switch error {
                case LoginError.emptyDetails:
                    self.showError(error: "Please complete all fields.")

                default:
                    print("Unable to login: \(error)")
                }
            } else {
                self.transitionToHome()
            }
        }
    }
}


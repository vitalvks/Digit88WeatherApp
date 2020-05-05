//
//  ViewController.swift
//  Digit88WhetherApp
//
//  Created by Sudhakar on 03/05/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import LocalAuthentication

class ViewController: UIViewController, LoginButtonDelegate, SigninViewProtocol, UITextFieldDelegate, WeatherReportProtocol {
    
    var signinViewModel = SigninViewModel()
    let fbLoginButton = FBLoginButton()
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var userNameFld: UITextField!
    @IBOutlet weak var passwordFld: UITextField!
    @IBOutlet weak var fbBtnHolderView: UIView!
    var weatherVC: WeatherReportViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.signinViewModel.delegate = self
        self.userNameFld.delegate = self
        self.passwordFld.delegate = self
        self.facebookLoginSetup()
        self.fbBtnHolderView.layer.cornerRadius = self.fbBtnHolderView.frame.size.height / 2
    }
    
    //MARK:facebook Login Setup methods
    func facebookLoginSetup() {
        self.fbLoginButton.delegate = self
        self.fbLoginButton.frame = self.fbBtnHolderView.bounds
        self.fbBtnHolderView.addSubview(self.fbLoginButton)
        
        self.fbLoginButton.permissions = ["public_profile", "email"]
        
        if let token = AccessToken.current, !token.isExpired {
            signinViewModel.getuserdetails()
        }
    }
    
    @IBAction func signinButtonTapped(sender: UIButton) {
        if userNameFld.text?.count ?? 0 > 0 && passwordFld.text?.count ?? 0 > 0 {
            self.signinViewModel.userInfo = UserInfoModel()
            self.signinViewModel.userInfo?.email = userNameFld.text
            self.signinViewModel.userInfo?.name = userNameFld.text
            self.navigateToWeatherReportScreen()
        }
    }
    
    @IBAction func fingerPrintButtonTapped(sender: UIButton) {
        self.authenticateUserTouchID()
    }
    
    func authenticateUserTouchID() {
            let localAuthenticationContext = LAContext()
            localAuthenticationContext.localizedFallbackTitle = "Use Passcode"

            var authError: NSError?
            let reasonString = "Authentication is needed to access your Weather Report Screen."

            if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString) { success, evaluateError in
                    if success {
                        
                        //TODO: User authenticated successfully, take appropriate action
                        self.navigateToWeatherReportScreen()
                        
                    } else {
                        //TODO: User did not authenticate successfully, look at error and take appropriate action
                        guard let error = evaluateError else {
                            return
                        }
                        
                        print(self.signinViewModel.evaluateAuthenticationPolicyMessageForLA(errorCode: error._code))
                        
                        //TODO: If you have choosen the 'Fallback authentication mechanism selected' (LAError.userFallback). Handle gracefully
                    }
                }
            } else {
                
                guard let error = authError else {
                    return
                }
                //TODO: Show appropriate alert if biometry/TouchID/FaceID is lockout or not enrolled
                print(self.signinViewModel.evaluateAuthenticationPolicyMessageForLA(errorCode: error.code))
            }
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if ((textField == userNameFld) && (textField.text != "")) {
            passwordFld.becomeFirstResponder()
        }
        if ((textField == passwordFld) && (textField.text != "")) {
            self.navigateToWeatherReportScreen()
        }
        
        return true
    }
    
    func navigateToWeatherReportScreen() {
        weatherVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WeatherReportViewController") as? WeatherReportViewController
        weatherVC?.delegate = self
        weatherVC?.userName = self.signinViewModel.userInfo?.name
        self.navigationController?.pushViewController(weatherVC!, animated: true)
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if ((error) != nil) {
            // Process error
        }
        else if result!.isCancelled {
            // Handle cancellations
        }
        else {
            signinViewModel.getuserdetails()
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    func logOutTapped() {
        self.userNameFld.text = ""
        self.passwordFld.text = ""
        if let token = AccessToken.current, !token.isExpired {
            LoginManager().logOut()
        }
    }
}


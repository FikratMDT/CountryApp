//
//  LoginVC.swift
//  CountryApp
//
//  Created by Fikrat on 22.11.22.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTextLogin: UITextField!
    @IBOutlet weak var passwordTextLogin: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextLogin.resignFirstResponder()
    }
    
    @IBAction func loginButton(_ sender: Any) {
    }
    
    @IBAction func registerButton(_ sender: Any) {
    }
    
    @IBAction func showPasswordButton(_ sender: Any) {
        
        passwordTextLogin.isSecureTextEntry = false
    }
}

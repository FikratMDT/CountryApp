//
//  RegisterVC.swift
//  CountryApp
//
//  Created by Fikrat on 05.12.22.
//

import UIKit

class RegisterVC: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var surnameText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var repeatePasswordText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func registerButton(_ sender: Any) {
    }
}

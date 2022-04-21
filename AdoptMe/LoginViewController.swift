//
//  LoginViewController.swift
//  AdoptMe
//
//  Created by Alan Vuong on 4/21/22.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onRegister(_ sender: Any) {
        let user = PFUser()
//        user.username = usernameField.text;
//        user.password = passwordField.text;
        self.performSegue(withIdentifier: "registerSegue", sender: nil)
//        user.signUpInBackground { (success, error) in
//            if (success) {
//                self.performSegue(withIdentifier: "loginSegue", sender: nil)
//            } else {
//                print("Error: \(error?.localizedDescription)")
//            }
//        }
    }
}

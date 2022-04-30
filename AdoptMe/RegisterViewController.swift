//
//  RegisterViewController.swift
//  AdoptMe
//
//  Created by Alan Vuong on 4/21/22.
//

import UIKit
import Parse

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    
    @IBAction func onBackButton(_ sender: Any) {
        dismiss(animated:true, completion: nil)
    }
    @IBAction func onSignUpButton(_ sender: Any) {
        let user = PFUser();
        user.username = usernameField.text
        user.password = passwordField.text
        user.email    = emailField.text
        
        user.signUpInBackground {(success, error) in
            if (success) {
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
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

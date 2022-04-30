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
        
        // Create space at beginning of all textFields
        usernameField.setLeftPaddingPoints(10)
        passwordField.setLeftPaddingPoints(10)
        emailField.setLeftPaddingPoints(10)
    }
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    
    @IBAction func onBackButton(_ sender: Any) {
        dismiss(animated:true, completion: nil)
    }
    @IBAction func onSignUpButton(_ sender: Any) {
        //self.performSegue(withIdentifier: "signInSegue", sender: nil)
        let user = PFUser();
        user.username = usernameField.text
        user.password = passwordField.text
        user.email    = emailField.text
        
        user.signUpInBackground {(success, error) in
            // If signUp successful, then segue to Login screen. Else display error
            if (success) {
                print("-------  Should Segue")
                self.performSegue(withIdentifier: "signUpSegue", sender: self.signUpBtn)
            }
            else {
                print("-------  Should NOT Segue")
                print("Error: \(error!.localizedDescription)")
                let uialert = UIAlertController(title: "Try Again", message: "\(error!.localizedDescription)", preferredStyle: .alert)
                uialert.addAction( UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
                
                self.present(uialert, animated: true, completion: nil)

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

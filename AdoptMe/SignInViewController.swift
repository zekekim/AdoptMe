//
//  SignInViewController.swift
//  AdoptMe
//
//  Created by Alan Vuong on 4/21/22.
//

import UIKit
import Parse

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usernameField.setLeftPaddingPoints(10)
        passwordField.setLeftPaddingPoints(10)
    }
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    
    @IBAction func onBackButton(_ sender: Any) {
        dismiss(animated:true, completion: nil)
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { user, error in
            if(user != nil) {
                self.performSegue(withIdentifier: "signInSegue", sender: self.signInBtn)
            } else {
                print("Error: \(error!.localizedDescription)")
                
                // Display error alert to screen
                let uialert = UIAlertController(title: "Try Again", message: "\(error!.localizedDescription)", preferredStyle: .alert)
                uialert.addAction( UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
                self.present(uialert, animated: true, completion: nil)
            }
        }
        
        
        
        
//        user.signUpInBackground {(success, error) in
//            // If signUp successful, then segue to Login screen. Else display error
//            if (success) {
//                print("-------  Should Segue")
//                self.performSegue(withIdentifier: "signInSegue", sender: self.signUpBtn)
//            }
//            else {
//                print("-------  Should NOT Segue")
//                print("Error: \(error!.localizedDescription)")
//                let uialert = UIAlertController(title: "Try Again", message: "\(error!.localizedDescription)", preferredStyle: .alert)
//                uialert.addAction( UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
//
//                self.present(uialert, animated: true, completion: nil)
//
//            }
//        }
//        
//        
//        
        
        
        
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

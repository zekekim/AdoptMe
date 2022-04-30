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
        self.performSegue(withIdentifier: "registerSegue", sender: nil)
    }
}

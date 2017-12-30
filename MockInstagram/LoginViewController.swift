//
//  LoginViewController.swift
//  MockInstagram
//
//  Created by Zhaoya Sun on 12/24/17.
//  Copyright © 2017 Zhaoya Sun. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onLogin(_ sender: Any) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let username = usernameTextField.text
        let password = passwordTextField.text
        PFUser.logInWithUsername(inBackground: username!, password: password!) { (user: PFUser?, error: Error?) in
            if let error = error {
                MBProgressHUD.hide(for: self.view, animated: true)
                print("error: \(error.localizedDescription)")
            } else {
                MBProgressHUD.hide(for: self.view, animated: true)
                print("logged in")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    
    @IBAction func onSignup(_ sender: Any) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let newUser = PFUser()
        newUser.username = usernameTextField.text
        newUser.password = passwordTextField.text
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                print("user regitration successful")
                MBProgressHUD.hide(for: self.view, animated: true)
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                MBProgressHUD.hide(for: self.view, animated: true)
                print("error: \(error?.localizedDescription)")
            }
        }
    }
   
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

   

}

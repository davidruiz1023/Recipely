//
//  LoginViewController.swift
//  Recipely
//
//  Created by Mariana Duarte on 11/9/20.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBAction func Login(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
          if user != nil {
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
          } else {
            let error = error as! NSError
            print("Error Domain: \(error.domain)")
            print("Error Response Code: \(error.code)")
            print("Error Description: \(error.localizedDescription)")
            print("Error User Info: \(error.userInfo)")
          }
        }
        
    }
    
    @IBAction func Signup(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                let error = error as! NSError
                print("Error Domain: \(error.domain)")
                print("Error Response Code: \(error.code)")
                print("Error Description: \(error.localizedDescription)")
                print("Error User Info: \(error.userInfo)")
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

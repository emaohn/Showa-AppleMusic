//
//  LoginViewController.swift
//  Showa-AppleMusic
//
//  Created by Emmie Ohnuki on 3/23/19.
//  Copyright © 2019 Emmie Ohnuki. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        loginButton.layer.shadowOpacity = 0.5
        loginButton.layer.shadowOffset = CGSize.zero
        loginButton.layer.shadowColor = UIColor.black.cgColor
        loginButton.layer.shadowRadius = 10
        loginButton.layer.cornerRadius = 5
        loginButton.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        authUI.delegate = self
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
}

extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
            return
        }
        
        guard let user = authDataResult?.user
            else { return }
        
        let userRef = Database.database().reference().child("users").child(user.uid)
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let user = Person(snapshot: snapshot) {
                Person.setCurrent(user, writeToUserDefaults: true)
                
                let storyboard = UIStoryboard(name: "Main", bundle: .main)
                if let initialViewController = storyboard.instantiateInitialViewController() {
                    self.view.window?.rootViewController = initialViewController
                    self.view.window?.makeKeyAndVisible()
                }
            } else {
                self.performSegue(withIdentifier: "toCreateUsername", sender: self)
            }
        })
    }
}



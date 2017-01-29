//
//  ViewController.swift
//  Systemly
//
//  Created by Gabriel Ducharme on 2017-01-26.
//  Copyright © 2017 Gabriel Ducharme. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseDatabaseUI
import FirebaseGoogleAuthUI
import FirebaseFacebookAuthUI

class ViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                print("User is signed in.")
                let childRef = FIRDatabase.database().reference(withPath: "user_profiles")
                
                childRef.child(user.uid).child("name").observe(.value, with: { snapshot in
                    
                    print(snapshot.value)
                    self.userNameLabel.text = "Hello \(snapshot.value!)"
                    
                })
                
            } else {
                print("No user is signed in.")
                self.userNameLabel.text = "\("please sign in")"
            }
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signoutButton() {
        
        print("trying to sign use out")
       try! FIRAuth.auth()!.signOut()
        
    }
    
}


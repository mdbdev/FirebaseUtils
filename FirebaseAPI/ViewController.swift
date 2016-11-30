//
//  ViewController.swift
//  FirebaseAPI
//
//  Created by Mudit Mittal on 11/16/16.
//  Copyright © 2016 Mobile Developers of Berkeley. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /**
         * EXAMPLES ON HOW TO USE FIREBASEUTILS QUERY METHODS
         */
        
        FIRAuth.auth()?.signIn(withEmail: "your_email", password: "your_password_here", completion: nil)
        print("Sign in Successful!")
        // QUERYBYID example
        let ref = FIRDatabase.database().reference(withPath: "cities")
        let firebaseUtils = FirebaseUtils()
        let block = { object -> Void in
            print(object)
        }
        let errorBlock = { error
            -> Void in
            print(error)
        }
        firebaseUtils.queryById(id: "380", ref: ref, withBlock: block, errorBlock: errorBlock)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


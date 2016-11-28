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
        
        FIRAuth.auth()?.signIn(withEmail: "mudit@google.com", password: "fuckyou", completion: nil)
        print("Sign in Successful!")
        // QUERYBYID example
        let ref = FIRDatabase.database().reference(withPath: "users")
        let firebaseUtils = FirebaseUtils()
        let block = { object -> Void in
            print(object)
        }
        firebaseUtils.queryByStringContains(fieldName: "image", ref: ref, inputValue: "https://www.facebook.com/photo.php?fbid=896520063825211&set=a.112631992214026.22144.100004016785310&type=3&source=11", withBlock: block)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


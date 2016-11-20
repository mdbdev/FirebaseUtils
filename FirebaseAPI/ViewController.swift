//
//  ViewController.swift
//  FirebaseAPI
//
//  Created by Mudit Mittal on 11/16/16.
//  Copyright © 2016 Mobile Developers of Berkeley. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let ref = FIRDatabase.database().reference(withPath: "users")
        let firebaseUtils = FirebaseUtils()
        firebaseUtils.queryById(id: "1", ref: ref)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


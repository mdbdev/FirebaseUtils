//
//  ParseToFirebase.swift
//  FirebaseAPI
//
//  Created by Mudit Mittal on 11/16/16.
//  Copyright © 2016 Mobile Developers of Berkeley. All rights reserved.
//

import Foundation
import Firebase

class FirebaseUtils {
    
    func queryById(id : String, ref : FIRDatabaseReference) {
        print(id)
        print("TEST")
        print(ref)
        ref.child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            if (!snapshot.exists()) {
                //return 0
            } else {
                let value = snapshot.value as! NSDictionary
                print(value)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}

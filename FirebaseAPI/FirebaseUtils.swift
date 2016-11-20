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
    
    /** 
     * queryById
     *
     * @params id (String), ref (FIRDatabaseReference)
     * @return JSON object with id as its parent
     */
    func queryById(id : String, ref : FIRDatabaseReference) { // NEED TO FIGURE OUT TYPE THINGY
        print(id)
        print("TEST")
        print(ref)
        ref.child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            
            print(snapshot)
            if (!snapshot.exists()) {
                // REPLACE THIS WITH RETURN SOMETHING NIL
            } else {
                let returnVal = snapshot.value as! NSDictionary // NEED TO FIGURE OUT TYPE
                print(returnVal)
                // FIGURE OUT HOW TO RETURN RETURNVAL
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    /**
     * queryByFieldContains: compares values for each FIELDNAME to see
     * they contain the given VALUE
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (NSObject)
     * @return array of children that contain VALUE
     */
    func queryByFieldContains(fieldName : String, ref : FIRDatabaseReference, inputValue : NSObject) {
        ref.child(fieldName).observeSingleEvent(of: .value, with: { (snapshot) in
            if (!snapshot.exists()) {
                // REPLACE THIS WITH RETURN SOMETHING NIL
            } else {
                var results : [NSObject] = []
                for childSnapshot in snapshot.children {
                    let snapshotValue = (childSnapshot as AnyObject).value as! NSDictionary
                    if snapshotValue.contains(inputValue) {
                        results.append(snapshotValue)
                    }
                }
                // FIGURE OUT HOW TO RETURN RESULTS ARRAY
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    /**
     * queryByListContains: compares values for each FIELDNAME to see
     * if that value is contained in the list of INPUTVALUES
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValues (NSArray)
     * @return array of children that contain VALUE
     */
    func queryByListContains(fieldName : String, ref : FIRDatabaseReference, inputValues : NSArray) {
        ref.child(fieldName).observeSingleEvent(of: .value, with: { (snapshot) in
            if (!snapshot.exists()) {
                // REPLACE THIS WITH RETURN SOMETHING NIL
            } else {
                var results : [NSObject] = []
                for childSnapshot in snapshot.children {
                    let snapshotValue = (childSnapshot as AnyObject).value as! NSDictionary
                    if inputValues.contains(snapshotValue) {
                        results.append(snapshotValue)
                    }
                }
                // FIGURE OUT HOW TO RETURN RESULTS ARRAY
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    /**
     * queryByEqualTo: compare values for each FIELDNAME
     * to see if that value is equal to INPUTVALUE
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (NSObject)
     * @return array of children that are equal to the INPUTVALUE
     */
    func queryByEqualTo(fieldName : String, ref : FIRDatabaseReference, inputValue : NSObject) {
        ref.child(fieldName).observeSingleEvent(of: .value, with: { (snapshot) in
            if (!snapshot.exists()) {
                // REPLACE THIS WITH RETURN SOMETHING NIL
            } else {
                var results : [NSObject] = []
                for childSnapshot in snapshot.children {
                    let snapshotValue = (childSnapshot as AnyObject).value as! NSDictionary
                    if snapshotValue.equals(inputValue) {
                        results.append(snapshotValue)
                    }
                }
                // FIGURE OUT HOW TO RETURN RESULTS ARRAY
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    /**
     * queryByNotEqualTo: compare values for each FIELDNAME
     * to see if that value is not equal to INPUTVALUE
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (NSObject)
     * @return array of children that are not equal to the INPUTVALUE
     */
    func queryByNotEqualTo(fieldName : String, ref : FIRDatabaseReference, inputValue : NSObject) {
        ref.child(fieldName).observeSingleEvent(of: .value, with: { (snapshot) in
            if (!snapshot.exists()) {
                // REPLACE THIS WITH RETURN SOMETHING NIL
            } else {
                var results : [NSObject] = []
                for childSnapshot in snapshot.children {
                    let snapshotValue = (childSnapshot as AnyObject).value as! NSDictionary
                    if !(snapshotValue.equals(inputValue)) {
                        results.append(snapshotValue)
                    }
                }
                // FIGURE OUT HOW TO RETURN RESULTS ARRAY
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    /**
     * queryByLessThan: compare values for each FIELDNAME
     * to see if that value is less than INPUTVALUE
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (NSObject)
     * @return array of children that are less than the INPUTVALUE
     */
    func queryByLessThan(fieldName : String, ref : FIRDatabaseReference, inputValue : NSObject) {
        ref.child(fieldName).observeSingleEvent(of: .value, with: { (snapshot) in
            if (!snapshot.exists()) {
                // REPLACE THIS WITH RETURN SOMETHING NIL
            } else {
                var results : [NSObject] = []
                for childSnapshot in snapshot.children {
                    let snapshotValue = (childSnapshot as AnyObject).value as! NSDictionary
                    if (snapshotValue < inputValue) {
                        results.append(snapshotValue)
                    }
                }
                // FIGURE OUT HOW TO RETURN RESULTS ARRAY
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    /**
     * queryByGreaterThan: compare values for each FIELDNAME
     * to see if that value is greater than INPUTVALUE
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (NSObject)
     * @return array of children that are greater than the INPUTVALUE
     */
    func queryByGreaterThan(fieldName : String, ref : FIRDatabaseReference, inputValue : NSObject) {
        ref.child(fieldName).observeSingleEvent(of: .value, with: { (snapshot) in
            if (!snapshot.exists()) {
                // REPLACE THIS WITH RETURN SOMETHING NIL
            } else {
                var results : [NSObject] = []
                for childSnapshot in snapshot.children {
                    let snapshotValue = (childSnapshot as AnyObject).value as! NSDictionary
                    if (snapshotValue > inputValue) {
                        results.append(snapshotValue)
                    }
                }
                // FIGURE OUT HOW TO RETURN RESULTS ARRAY
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    /**
     * queryByFileEquals: compare urls for each FIELDNAME, 
     * downloads the file at that url in bytes, and then compares those bytes to FILEBYTES
     *
     * @params fieldName (String), ref (FIRDatabaseReference), fileBytes (???)
     * @return ??? NOT SURE WHAT THIS RETURNS
     */
    func queryByFileEquals(fieldName : String, ref : FIRDatabaseReference, fileBytes : NSData) {
        // NOT SURE THE TYPE OF THE FILEBYTES TO BE PASSED IN --> NSDATA OR BYTE[] OR ????
        // NO IDEA HOW TO D THIS
    }
    
    
}

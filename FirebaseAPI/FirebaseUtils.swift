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
     * - ASYNC
     *
     * @params id (String), ref (FIRDatabaseReference), childType (AnyClass) // FIGURE OUT TYPE THING
     * @return JSON object with id as its parent
     */
    func queryById(id : String, ref : FIRDatabaseReference, withBlock: @escaping ([String: Any]) -> Void) { // NEED TO FIGURE OUT TYPE THINGY
        print(id)
        print(ref)
        ref.child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            if (snapshot.exists()) {
                if let returnVal = snapshot.value as? [String: Any] {
                    withBlock(returnVal)
                }
            }
        })
        { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    /*
    /**
     * queryByFieldContains: compares values for each FIELDNAME to see
     * they contain the given VALUE
     *  - ASYNC
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (NSObject)
     * @return array of children that contain VALUE
     */
    func queryByFieldContains(fieldName : String, ref : FIRDatabaseReference, inputValue : String) {
        ref.child(fieldName).observeSingleEvent(of: .value, with: { (snapshot) in
            if (!snapshot.exists()) {
                // REPLACE THIS WITH RETURN SOMETHING NIL
            } else {
                var results : [NSObject] = []
                
                // THE CODE BELOW I'M NOT SURE OF
                // IM UNCLEAR IF THIS FUNCTION WANTS TO CHECK THE CHILDREN OF THE SNAPSHOT
                // OR IF IT WANTS TO CHECK IF VALUE PROPERTIES EXIST
                
                let enumerator = snapshot.children
                while let snapshotValue = enumerator.nextObject() as? FIRDataSnapshot {
                    if snapshotValue.hasChild(inputValue) {
                        results.append(snapshotValue)
                    }
                }
                
                
//                for childSnapshot in snapshot.children {
//                    let snapshotValue = childSnapshot.value as! NSDictionary
//                    if snapshotValue.contains(inputValue) {
//                        results.append(snapshotValue)
//                    }
//                }
                
                // FIGURE OUT HOW TO RETURN RESULTS ARRAY
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    /**
     * queryByListContains: compares values for each FIELDNAME to see
     * if that value is contained in the list of INPUTVALUES
     * - ASYNC
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
//                    let snapshotValue = (childSnapshot as AnyObject).value as! NSDictionary
//                    if inputValues.contains(snapshotValue) {
//                        results.append(snapshotValue)
//                    }
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
     * - ASYNC
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
//                    let snapshotValue = (childSnapshot as AnyObject).value as! NSDictionary
//                    if snapshotValue.equals(inputValue) {
//                        results.append(snapshotValue)
//                    }
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
     * - ASYNC
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
//                    let snapshotValue = (childSnapshot as AnyObject).value as! NSDictionary
//                    if !(snapshotValue.equals(inputValue)) {
//                        results.append(snapshotValue)
//                    }
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
     * - ASYNC
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
//                    let snapshotValue = (childSnapshot as AnyObject).value as! NSDictionary
//                    if (snapshotValue < inputValue) {
//                        results.append(snapshotValue)
//                    }
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
     * - ASYNC
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
//                    let snapshotValue = (childSnapshot as AnyObject).value as! NSDictionary
//                    if (snapshotValue > inputValue) {
//                        results.append(snapshotValue)
//                    }
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
     * - ASYNC
     *
     * @params fieldName (String), ref (FIRDatabaseReference), fileBytes (???)
     * @return ??? NOT SURE WHAT THIS RETURNS
     */
    func queryByFileEquals(fieldName : String, ref : FIRDatabaseReference, fileBytes : NSData) {
        ref.child(fieldName).observeSingleEvent(of: .value, with: { (snapshot) in
            if (!snapshot.exists()) {
                // REPLACE THIS WITH RETURN SOMETHING NIL
            } else {
                // NOT SURE THE TYPE OF THE FILEBYTES TO BE PASSED IN --> NSDATA OR BYTE[] OR ????
                // NO IDEA HOW TO Do THIS
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    */
}

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
    
    enum FirebaseUtilsError : Error {
        case NotRelational
        case QueryError
    }
    
    /**
     * queryById: retrieve child of reference that matches the input id
     *
     * @params id (String), ref (FIRDatabaseReference), withBlock, errorBlock
     * @return JSON object with id as its parent
     */
    
    func queryById(id : String, ref : FIRDatabaseReference, withBlock: @escaping (Any) -> Void, errorBlock: @escaping (FirebaseUtilsError?) -> Void) {
        assertRef(ref: ref, success: {
            ref.child(id).observeSingleEvent(of: .value, with: { (snapshot) in
                if (snapshot.exists()) {
                    if let returnVal = snapshot.value as? Any {
                        withBlock(returnVal)
                    }
                } else {
                    errorBlock(.QueryError)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }, errorBlock: errorBlock)
    }
    
    /**
     * queryByFieldContains: compares values for each FIELDNAME to see if they contain the given INPUTVALUE
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (String), withBlock, errorBlock
     * @return array of children that contain VALUE
     */
   
    func queryByStringContains(fieldName : String, ref : FIRDatabaseReference, inputValue : String, withBlock: @escaping ([NSObject]) -> Void, errorBlock: @escaping (FirebaseUtilsError) -> Void) {
        assertRef(ref: ref, success: {
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if (snapshot.exists()) {
                    var results : [NSDictionary] = []
                    for childSnapshot in snapshot.children.allObjects as! [FIRDataSnapshot] {
                        let childSnapshotValue = childSnapshot.value as! NSDictionary
                        if let fieldNameValue = childSnapshotValue[fieldName] as? String {
                            if (fieldNameValue.contains(inputValue)) {
                                results.append(childSnapshotValue)
                            }
                        }
                    }
                    withBlock(results)
                } else {
                    errorBlock(.QueryError)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }, errorBlock: errorBlock)
    }
    
    
    /**
     * queryByListContains: compares values for each FIELDNAME to see
     * if that value is contained in the list of INPUTVALUE
     * - ASYNC
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (Any), withBlock, errorBlock
     * @return array of children that contain VALUE
     */
    
    func queryByListContains(fieldName : String, ref : FIRDatabaseReference, inputValue : Any, withBlock: @escaping ([NSObject]) -> Void, errorBlock: @escaping (FirebaseUtilsError) -> Void) {
        assertRef(ref: ref, success: {
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if (snapshot.exists()) {
                    var results : [NSDictionary] = []
                    for childSnapshot in snapshot.children.allObjects as! [FIRDataSnapshot] {
                        let childSnapshotValue = childSnapshot.value as! NSDictionary
                        if let fieldNameValue = childSnapshotValue[fieldName] as? [NSObject] {
                            if (fieldNameValue.contains(inputValue as! NSObject)) {
                                results.append(childSnapshotValue)
                            }
                        }
                    }
                    withBlock(results)
                } else {
                    errorBlock(.QueryError)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }, errorBlock: errorBlock)
    }
    
    /**
     * queryByListContainsSublist: compares values for each FIELDNAME to see
     * if that value contains all the elements of INPUTVALUE
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue ([Any]), withBlock, errorBlock
     * @return array of children that contain VALUE
     */
    
    func queryByListContainsSublist(fieldName : String, ref : FIRDatabaseReference, inputValue : [Any], withBlock: @escaping ([NSObject]) -> Void, errorBlock: @escaping (FirebaseUtilsError) -> Void) {
        assertRef(ref: ref, success: {
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if (snapshot.exists()) {
                    var results : [NSDictionary] = []
                    for childSnapshot in snapshot.children.allObjects as! [FIRDataSnapshot] {
                        let childSnapshotValue = childSnapshot.value as! NSDictionary
                        if let fieldNameValue = childSnapshotValue[fieldName] as? [NSObject] {
                            var containsAll = true
                            for element in inputValue {
                                if (!fieldNameValue.contains(element as! NSObject)) {
                                    containsAll = false
                                }
                            }
                            if (containsAll) {
                                results.append(childSnapshotValue)
                            }
                        }
                    }
                    withBlock(results)
                } else {
                    errorBlock(.QueryError)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }, errorBlock: errorBlock)
    }

    
    /**
     * queryByNotEqualTo: compare values for each FIELDNAME
     * to see if that value is not equal to INPUTVALUE,
     * in which the INPUTVALUE is a String
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (String), withBlock, errorBlock
     * @return array of children that are not equal to the INPUTVALUE
     */
    
    func queryByNotEqualTo(fieldName : String, ref : FIRDatabaseReference, inputValue : String, withBlock: @escaping ([NSObject]) -> Void, errorBlock: @escaping (FirebaseUtilsError) -> Void) {
        assertRef(ref: ref, success: {
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if (snapshot.exists()) {
                    var results : [NSDictionary] = []
                    for childSnapshot in snapshot.children.allObjects as! [FIRDataSnapshot] {
                        let childSnapshotValue = childSnapshot.value as! NSDictionary
                        if let fieldNameValue = childSnapshotValue[fieldName] as? String {
                            if (fieldNameValue != inputValue as? String) {
                                results.append(childSnapshotValue)
                            }
                        }
                    }
                    withBlock(results)
                } else {
                    errorBlock(.QueryError)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }, errorBlock: errorBlock)
    }
    
    /**
     * queryByNotEqualTo: compare values for each FIELDNAME
     * to see if that value is not equal to INPUTVALUE,
     * in which the INPUTVALUE is a Float
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (Float), withBlock, errorBlock
     * @return array of children that are not equal to the INPUTVALUE
     */
    
    func queryByNotEqualTo(fieldName : String, ref : FIRDatabaseReference, inputValue : Float, withBlock: @escaping ([NSObject]) -> Void, errorBlock: @escaping (FirebaseUtilsError) -> Void) {
        assertRef(ref: ref, success: {
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if (snapshot.exists()) {
                    var results : [NSDictionary] = []
                    for childSnapshot in snapshot.children.allObjects as! [FIRDataSnapshot] {
                        let childSnapshotValue = childSnapshot.value as! NSDictionary
                        if let fieldNameValue = childSnapshotValue[fieldName] as? Float {
                            if (fieldNameValue != inputValue as? Float) {
                                results.append(childSnapshotValue)
                            }
                        }
                    }
                    withBlock(results)
                } else {
                    errorBlock(.QueryError)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }, errorBlock: errorBlock)
    }

    
    /**
     * queryByLessThan: compare values for each FIELDNAME
     * to see if that value is less than INPUTVALUE,
     * in which the INPUTVALUE is a String
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (String), withBlock, errorBlock
     * @return array of children that are less than the INPUTVALUE
     */
    
    func queryByLessThan(fieldName : String, ref : FIRDatabaseReference, inputValue : String, withBlock: @escaping ([NSObject]) -> Void, errorBlock: @escaping (FirebaseUtilsError) -> Void) {
        assertRef(ref: ref, success: {
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if (snapshot.exists()) {
                    var results : [NSDictionary] = []
                    for childSnapshot in snapshot.children.allObjects as! [FIRDataSnapshot] {
                        let childSnapshotValue = childSnapshot.value as! NSDictionary
                        if let fieldNameValue = childSnapshotValue[fieldName] as? String {
                            if (fieldNameValue < (inputValue as? String)!) {
                                results.append(childSnapshotValue)
                            }
                        }
                    }
                    withBlock(results)
                } else {
                    errorBlock(.QueryError)
                }
            }) { (error) in
                print(error.localizedDescription)
            }

        }, errorBlock: errorBlock)
    }
    
    /**
     * queryByLessThan: compare values for each FIELDNAME
     * to see if that value is less than INPUTVALUE,
     * in which the INPUTVALUE is a Float
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (Float), withBlock, errorBlock
     * @return array of children that are less than the INPUTVALUE
     */
    
    func queryByLessThan(fieldName : String, ref : FIRDatabaseReference, inputValue : Float, withBlock: @escaping ([NSObject]) -> Void, errorBlock: @escaping (FirebaseUtilsError) -> Void) {
        assertRef(ref: ref, success: {
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if (snapshot.exists()) {
                    var results : [NSDictionary] = []
                    for childSnapshot in snapshot.children.allObjects as! [FIRDataSnapshot] {
                        let childSnapshotValue = childSnapshot.value as! NSDictionary
                        if let fieldNameValue = childSnapshotValue[fieldName] as? Float {
                            if (fieldNameValue < (inputValue as? Float)!) {
                                results.append(childSnapshotValue)
                            }
                        }
                    }
                    withBlock(results)
                } else {
                    errorBlock(.QueryError)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }, errorBlock: errorBlock)
    }

    /**
     * queryByLessThanOrEqualTo: compare values for each FIELDNAME
     * to see if that value is less than or equal to the INPUTVALUE,
     * in which the INPUTVALUE is a String
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (String), withBlock, errorBlock
     * @return array of children that are less than or equal to the INPUTVALUE
     */
    
    func queryByLessThanOrEqualTo(fieldName : String, ref : FIRDatabaseReference, inputValue : String, withBlock: @escaping ([NSObject]) -> Void, errorBlock: @escaping (FirebaseUtilsError) -> Void) {
        assertRef(ref: ref, success: {
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if (snapshot.exists()) {
                    var results : [NSDictionary] = []
                    for childSnapshot in snapshot.children.allObjects as! [FIRDataSnapshot] {
                        let childSnapshotValue = childSnapshot.value as! NSDictionary
                        if let fieldNameValue = childSnapshotValue[fieldName] as? String {
                            if (fieldNameValue <= (inputValue as? String)!) {
                                results.append(childSnapshotValue)
                            }
                        }
                    }
                    withBlock(results)
                } else {
                    errorBlock(.QueryError)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }, errorBlock: errorBlock)
    }
    
    /**
     * queryByLessThanOrEqualTo: compare values for each FIELDNAME
     * to see if that value is less than or equal to the INPUTVALUE,
     * in which the INPUTVALUE is a Float
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (Float), withBlock, errorBlock
     * @return array of children that are less than or equal to the INPUTVALUE
     */
    
    func queryByLessThanOrEqualTo(fieldName : String, ref : FIRDatabaseReference, inputValue : Float, withBlock: @escaping ([NSObject]) -> Void, errorBlock: @escaping (FirebaseUtilsError) -> Void) {
        assertRef(ref: ref, success: {
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if (snapshot.exists()) {
                    var results : [NSDictionary] = []
                    for childSnapshot in snapshot.children.allObjects as! [FIRDataSnapshot] {
                        let childSnapshotValue = childSnapshot.value as! NSDictionary
                        if let fieldNameValue = childSnapshotValue[fieldName] as? Float {
                            if (fieldNameValue <= (inputValue as? Float)!) {
                                results.append(childSnapshotValue)
                            }
                        }
                    }
                    withBlock(results)
                } else {
                    errorBlock(.QueryError)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }, errorBlock: errorBlock)
    }

    /**
     * queryByGreaterThan: compare values for each FIELDNAME
     * to see if that value is greater than INPUTVALUE,
     * in which the INPUTVALUE is a String
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (String), withBlock, errorBlock
     * @return array of children that are greater than the INPUTVALUE
     */
    
    func queryByGreaterThan(fieldName : String, ref : FIRDatabaseReference, inputValue : String, withBlock: @escaping ([NSObject]) -> Void, errorBlock: @escaping (FirebaseUtilsError) -> Void) {
        assertRef(ref: ref, success: {
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if (snapshot.exists()) {
                    var results : [NSDictionary] = []
                    for childSnapshot in snapshot.children.allObjects as! [FIRDataSnapshot] {
                        let childSnapshotValue = childSnapshot.value as! NSDictionary
                        if let fieldNameValue = childSnapshotValue[fieldName] as? String {
                            if (fieldNameValue > (inputValue as? String)!) {
                                results.append(childSnapshotValue)
                            }
                        }
                    }
                    withBlock(results)
                } else {
                    errorBlock(.QueryError)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }, errorBlock: errorBlock)
    }
    
    /**
     * queryByGreaterThan: compare values for each FIELDNAME
     * to see if that value is greater than INPUTVALUE,
     * in which the INPUTVALUE is a Float
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (Float), withBlock, errorBlock
     * @return array of children that are greater than the INPUTVALUE
     */
    
    func queryByGreaterThan(fieldName : String, ref : FIRDatabaseReference, inputValue : Float, withBlock: @escaping ([NSObject]) -> Void, errorBlock: @escaping (FirebaseUtilsError) -> Void) {
        assertRef(ref: ref, success: {
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if (snapshot.exists()) {
                    var results : [NSDictionary] = []
                    for childSnapshot in snapshot.children.allObjects as! [FIRDataSnapshot] {
                        let childSnapshotValue = childSnapshot.value as! NSDictionary
                        if let fieldNameValue = childSnapshotValue[fieldName] as? Float {
                            if (fieldNameValue > (inputValue as? Float)!) {
                                results.append(childSnapshotValue)
                            }
                        }
                    }
                    withBlock(results)
                } else {
                    errorBlock(.QueryError)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }, errorBlock: errorBlock)
    }
    
    /**
     * queryByGreaterThanOrEqualTo: compare values for each FIELDNAME
     * to see if that value is greater than or equal to the INPUTVALUE,
     * in which the INPUTVALUE is a String
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (String), withBlock, errorBlock
     * @return array of children that are greater than or equal to the INPUTVALUE
     */
    
    func queryByGreaterThanOrEqualTo(fieldName : String, ref : FIRDatabaseReference, inputValue : String, withBlock: @escaping ([NSObject]) -> Void, errorBlock: @escaping (FirebaseUtilsError) -> Void) {
        assertRef(ref: ref, success: {
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if (snapshot.exists()) {
                    var results : [NSDictionary] = []
                    for childSnapshot in snapshot.children.allObjects as! [FIRDataSnapshot] {
                        let childSnapshotValue = childSnapshot.value as! NSDictionary
                        if let fieldNameValue = childSnapshotValue[fieldName] as? String {
                            if (fieldNameValue >= (inputValue as? String)!) {
                                results.append(childSnapshotValue)
                            }
                        }
                    }
                    withBlock(results)
                } else {
                    errorBlock(.QueryError)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }, errorBlock: errorBlock)
    }
    
    /**
     * queryByGreaterThanOrEqualTo: compare values for each FIELDNAME
     * to see if that value is greater than or equal to the INPUTVALUE,
     * in which the INPUTVALUE is a Float
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (Float), withBlock, errorBlock
     * @return array of children that are greater than or equal to the INPUTVALUE
     */
    
    func queryByGreaterThanOrEqualTo(fieldName : String, ref : FIRDatabaseReference, inputValue : Float, withBlock: @escaping ([NSObject]) -> Void, errorBlock: @escaping (FirebaseUtilsError) -> Void) {
        assertRef(ref: ref, success: {
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if (snapshot.exists()) {
                    var results : [NSDictionary] = []
                    for childSnapshot in snapshot.children.allObjects as! [FIRDataSnapshot] {
                        let childSnapshotValue = childSnapshot.value as! NSDictionary
                        if let fieldNameValue = childSnapshotValue[fieldName] as? Float {
                            if (fieldNameValue >= (inputValue as? Float)!) {
                                results.append(childSnapshotValue)
                            }
                        }
                    }
                    withBlock(results)
                } else {
                    errorBlock(.QueryError)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }, errorBlock: errorBlock)
    }
    
     /**
     * assertRef: asserts the validity of the reference
     *
     * @params ref (FIRDatabaseReference), errorBlock
     * @throw Error if reference does not exist or is invalid
     */
    
    private func assertRef(ref : FIRDatabaseReference, success: @escaping () -> Void, errorBlock: @escaping (FirebaseUtilsError) -> Void) {
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if (snapshot.exists()) {
                var verificationPassed = true
                if let refValue = snapshot.value as? NSArray {
                    for key in refValue {
                        if let value = key as? NSDictionary {
                            continue
                        } else {
                            verificationPassed = false
                        }
                        
                    }
                    (verificationPassed == true) ? success() : errorBlock(.NotRelational)
                } else {
                    errorBlock(.NotRelational)
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}

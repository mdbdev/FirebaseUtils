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
     * queryById 
     * - ASYNC
     *
     * @params id (String), ref (FIRDatabaseReference), childType (AnyClass) // FIGURE OUT TYPE THING
     * @return JSON object with id as its parent
     */
    
    func queryById(id : String, ref : FIRDatabaseReference, withBlock: @escaping (Any) -> Void) {
        assertRef(ref: ref)
        ref.child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            if (snapshot.exists()) {
                if let returnVal = snapshot.value as? Any {
                    withBlock(returnVal)
                }
            } else {
                //throw error
            }
        })
        { (error) in
            print(error.localizedDescription)
        }

    }
    
    /**
     * queryByFieldContains: compares values for each FIELDNAME to see
     * they contain the given VALUE
     *  - ASYNC
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (NSObject)
     * @return array of children that contain VALUE
     */
   
    func queryByStringContains(fieldName : String, ref : FIRDatabaseReference, inputValue : String, withBlock: @escaping ([NSObject]) -> Void) {
        assertRef(ref: ref)
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
                //throw error
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
     * @params fieldName (String), ref (FIRDatabaseReference), inputValues (Any)
     * @return array of children that contain VALUE
     */
    
    func queryByListContains(fieldName : String, ref : FIRDatabaseReference, inputValue : Any, withBlock: @escaping ([NSObject]) -> Void) {
        assertRef(ref: ref)
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
                //throw error
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    /**
     * queryByListContainsSublist: compares values for each FIELDNAME to see
     * if that value contains all the elements of INPUTVALUE
     * - ASYNC
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValues (NSArray)
     * @return array of children that contain VALUE
     */
    
    func queryByListContainsSublist(fieldName : String, ref : FIRDatabaseReference, inputValue : [Any], withBlock: @escaping ([NSObject]) -> Void) {
        assertRef(ref: ref)
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
                //throw error
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
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (String)
     * @return array of children that are not equal to the INPUTVALUE
     */
    
    func queryByNotEqualTo(fieldName : String, ref : FIRDatabaseReference, inputValue : String, withBlock: @escaping ([NSObject]) -> Void) {
        assertRef(ref: ref)
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
                //throw error
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
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (Float)
     * @return array of children that are not equal to the INPUTVALUE
     */
    
    func queryByNotEqualTo(fieldName : String, ref : FIRDatabaseReference, inputValue : Float, withBlock: @escaping ([NSObject]) -> Void) {
        assertRef(ref: ref)
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
                //throw error
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
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (String)
     * @return array of children that are less than the INPUTVALUE
     */
    
    func queryByLessThan(fieldName : String, ref : FIRDatabaseReference, inputValue : String, withBlock: @escaping ([NSObject]) -> Void) {
        assertRef(ref: ref)
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
                //throw error
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
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (Float)
     * @return array of children that are less than the INPUTVALUE
     */
    
    func queryByLessThan(fieldName : String, ref : FIRDatabaseReference, inputValue : Float, withBlock: @escaping ([NSObject]) -> Void) {
        assertRef(ref: ref)
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
                //throw error
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    /**
     * queryByLessThanOrEqualTo: compare values for each FIELDNAME
     * to see if that value is less than INPUTVALUE
     * - ASYNC
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (String)
     * @return array of children that are less than or equal to the INPUTVALUE
     */
    
    func queryByLessThanOrEqualTo(fieldName : String, ref : FIRDatabaseReference, inputValue : String, withBlock: @escaping ([NSObject]) -> Void) {
        assertRef(ref: ref)
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
                //throw error
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    /**
     * queryByLessThanOrEqualTo: compare values for each FIELDNAME
     * to see if that value is less than INPUTVALUE
     * - ASYNC
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (Float)
     * @return array of children that are less than or equal to the INPUTVALUE
     */
    
    func queryByLessThanOrEqualTo(fieldName : String, ref : FIRDatabaseReference, inputValue : Float, withBlock: @escaping ([NSObject]) -> Void) {
        assertRef(ref: ref)
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
                //throw error
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    /**
     * queryByGreaterThan: compare values for each FIELDNAME
     * to see if that value is less than INPUTVALUE
     * - ASYNC
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (String)
     * @return array of children that are greater than the INPUTVALUE
     */
    
    func queryByGreaterThan(fieldName : String, ref : FIRDatabaseReference, inputValue : String, withBlock: @escaping ([NSObject]) -> Void) {
        assertRef(ref: ref)
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
                //throw error
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    /**
     * queryByGreaterThan: compare values for each FIELDNAME
     * to see if that value is less than INPUTVALUE
     * - ASYNC
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (Float)
     * @return array of children that are greater than the INPUTVALUE
     */
    
    func queryByGreaterThan(fieldName : String, ref : FIRDatabaseReference, inputValue : Float, withBlock: @escaping ([NSObject]) -> Void) {
        assertRef(ref: ref)
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
                //throw error
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    /**
     * queryByGreaterThanOrEqualTo: compare values for each FIELDNAME
     * to see if that value is less than INPUTVALUE
     * - ASYNC
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (String)
     * @return array of children that are greater than or equal to the INPUTVALUE
     */
    
    func queryByGreaterThanOrEqualTo(fieldName : String, ref : FIRDatabaseReference, inputValue : String, withBlock: @escaping ([NSObject]) -> Void) {
        assertRef(ref: ref)
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
                //throw error
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    /**
     * queryByGreaterThanOrEqualTo: compare values for each FIELDNAME
     * to see if that value is less than INPUTVALUE
     * - ASYNC
     *
     * @params fieldName (String), ref (FIRDatabaseReference), inputValue (Float)
     * @return array of children that are greater than or equal to the INPUTVALUE
     */
    
    func queryByGreaterThanOrEqualTo(fieldName : String, ref : FIRDatabaseReference, inputValue : Float, withBlock: @escaping ([NSObject]) -> Void) {
        assertRef(ref: ref)
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
                //throw error
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    private func assertRef(ref : FIRDatabaseReference) {
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if (snapshot.exists()) {
                if let refValue = snapshot.value as? NSDictionary {
                    for key in refValue {
                        if let value = refValue[key] as? NSDictionary {
                            //pass
                        } else {
                            //throw error
                        }
                    }
                } else {
                    //throw error
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}

# FirebaseUtils

[![CI Status](http://img.shields.io/travis/Christine Munar/FirebaseUtils.svg?style=flat)](https://travis-ci.org/Christine Munar/FirebaseUtils)
[![Version](https://img.shields.io/cocoapods/v/FirebaseUtils.svg?style=flat)](http://cocoapods.org/pods/FirebaseUtils)
[![License](https://img.shields.io/cocoapods/l/FirebaseUtils.svg?style=flat)](http://cocoapods.org/pods/FirebaseUtils)
[![Platform](https://img.shields.io/cocoapods/p/FirebaseUtils.svg?style=flat)](http://cocoapods.org/pods/FirebaseUtils)

This is a simple Swift class that provides easy methods to query data from your Firebase Database.

This library allows users to treat their default tree structure database in Firebase as a relational database (similar to the usage of Parse).

All that is needed is to create your FIRDatabaseReference then pass it into one of our functions to retrieve your desired data. 

It includes the following query methods:
- queryById
- queryByStringContains
- queryByListContains
- queryByListContainsSublist
- queryByNotEqualTo
- queryByLessThan
- queryByLessThanOrEqualTo
- queryByGreaterThan
- queryByGreaterThanOrEqualTo

## Installation

Makre sure you're on the correct repo branch: 'FirebaseUtilsCocoaPod'

FirebaseUtils is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "FirebaseUtils"
```

## Required
Must install Firebase before use.

## How to use
First import Firebase and FirebaseAuth to your selected ViewController.
```swift
import Firebase
import FirebaseAuth
```
To sign into Firebase:
```swift
FIRAuth.auth()?.signIn(withEmail: "email@domain.com", password: "password", completion: nil)
```

Create your desired reference where you want to pull the data from:
```swift
let ref = FIRDatabase.database().reference(withPath: "users")
```

Create a variable to reference our FirebaseUtils:
```swift
let firebaseUtils = FirebaseUtils()
```

Create a block variable in which you determine what you want to do with the resulting object, such as print, return, etc.
(in this example, the object is being printed):
```swift
let block = { object -> Void in
print(object)
}
```

Use the firebaseUtils variable and block variable as a parameter to call any one of our functions above 
(in this example, queryByStringContains is being called):
```swift
firebaseUtils.queryByStringContains(fieldName: "image", ref: ref, inputValue: "https://www.example.com", withBlock: block)
```
## More Info

View our FirebaseUtils.swift file for more specifics on each function, the required parameters, and what results will be returned. 

## Support

Supports iOS 8 and above. Xcode 7.0 is required to build the latest code written in Swift 3.0.

## License

FirebaseUtils is available under the MIT license. See the LICENSE file for more info.



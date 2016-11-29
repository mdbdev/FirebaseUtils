
# FirebaseUtils

This is a simple Swift class that provides easy methods to query data from your Firebase Database.
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

## Installation with CocoaPods

Install FirebaseUtils with: [CocoaPods](http://cocoapods.org)

### Podfile

```ruby
use_frameworks!

pod 'FirebaseUtils', '~> 1.0.14'
```

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
Use that variable to call any one of our functions above (in this example, queryByStringContains is being called):
```swift
let block = { object -> Void in
            print(object)
        }
firebaseUtils.queryByStringContains(fieldName: "image", ref: ref, inputValue: "https://www.example.com", withBlock: block)
```

## Support

Supports iOS 8 and above. Xcode 7.0 is required to build the latest code written in Swift 3.0.

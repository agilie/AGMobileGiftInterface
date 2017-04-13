# AGMobileGiftInterface

[![CI Status](http://img.shields.io/travis/liptugamichael@gmail.com/AGMobileGiftInterface.svg?style=flat)](https://travis-ci.org/liptugamichael@gmail.com/AGMobileGiftInterface)
[![Version](https://img.shields.io/cocoapods/v/AGMobileGiftInterface.svg?style=flat)](http://cocoapods.org/pods/AGMobileGiftInterface)
[![License](https://img.shields.io/cocoapods/l/AGMobileGiftInterface.svg?style=flat)](http://cocoapods.org/pods/AGMobileGiftInterface)
[![Platform](https://img.shields.io/cocoapods/p/AGMobileGiftInterface.svg?style=flat)](http://cocoapods.org/pods/AGMobileGiftInterface)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

The developers of Agilie team would like to offer you our new lightweight open-source library called AGMobileGiftInterface. 
This library simplifies interaction with GIF images and can be easily integrated into your project.

When can you use AGMobileGiftInterface?
Use our library if you need to show a GIF image after performing a certain pre-specified action. AGMobileGiftInterface can also be helpful for creating animated greetings, designing splash screens or loading, upgrading and supplementing online games as well as in other similar cases.
Our library helps you achieve the desired result in an easy way with as little lines of code as possible.

### How does it work?

After an animated picture has been played, the controller managing it closes. And if you want to add a new image, just put it into the project and provide the GIF path as parameter and call method show. 

````objective-c

@IBAction func showFox(_ sender: Any) {
        AGMobileGiftInterface.show(gifName : "fox")
    }

@IBAction func showRabbit(_ sender: Any) {
        AGMobileGiftInterface.show(gifName : "rabbit")
    }

````

### Our example of using AGMobileGiftInterface
We’ve used this library when working on Easter greeting program. Quite simple, it has 3 GIF images in its reserve (Ladybird, Rabbit, Fox) but can also be supplemented with new ones. 
We made example to congratulate the use on the day of Easter.

## Usage

CocoaPods is the recommended way to add DisPlayer to your project:
 
1. Add a pod entry for AGMobileGiftInterface to your Podfile pod 'AGMobileGiftInterface'
2. Install the pod(s) by running pod installation.

## Requirements

AGMobileGiftInterface works on iOS 8.0+ and is compatible with ARC projects.
It depends on the following Apple frameworks, which should already be included with most Xcode templates:
You will need LLVM 3.0 or later in order to build “DisPlayer”

## Installation

AGMobileGiftInterface is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AGMobileGiftInterface"
```

## Author

This library is open-sourced by [Agilie Team](https://www.agilie.com)

## License

AGMobileGiftInterface is available under the MIT license. See the LICENSE file for more info.

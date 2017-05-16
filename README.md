# AGMobileGiftInterface

[![CI Status](http://img.shields.io/travis/liptugamichael@gmail.com/AGMobileGiftInterface.svg?style=flat)](https://travis-ci.org/liptugamichael@gmail.com/AGMobileGiftInterface)
[![Version](https://img.shields.io/cocoapods/v/AGMobileGiftInterface.svg?style=flat)](http://cocoapods.org/pods/AGMobileGiftInterface)
[![License](https://img.shields.io/cocoapods/l/AGMobileGiftInterface.svg?style=flat)](http://cocoapods.org/pods/AGMobileGiftInterface)
[![Platform](https://img.shields.io/cocoapods/p/AGMobileGiftInterface.svg?style=flat)](http://cocoapods.org/pods/AGMobileGiftInterface)

### GifPlaying:
<img src="https://cloud.githubusercontent.com/assets/4165054/25009817/bdf0869c-2070-11e7-97ea-860c239bae84.gif" alt="Fox" height="400" width="250" border ="50">   <img src="https://cloud.githubusercontent.com/assets/4165054/25009821/c176ebee-2070-11e7-8008-3a20881604b5.gif" alt="Rabbit" height="400" width="250">
<img src="https://cloud.githubusercontent.com/assets/4165054/25009823/c400d596-2070-11e7-8e70-4e8e89a4bad4.gif" alt="Ladybird" height="400" width="250">

### StartGravity:

<img src="https://cloud.githubusercontent.com/assets/4165054/26112030/7154b75a-3a5f-11e7-903a-af47b80318af.gif" alt="Everything" height="400" width="250" border ="50">

[Agilie Team](https://agilie.com/en/ios-development-services) would like to offer you our new lightweight open-source library called AGMobileGiftInterface. 
This library simplifies interaction with GIF images and can be easily integrated into your project.

When can you use AGMobileGiftInterface?

Use our library if you need to show a GIF image after performing a certain pre-specified action. Also our library can capture any interface (screen or view) and throws its UI elements over under the influence of gravity, so that one can move them from side to side obliquely.
AGMobileGiftInterface can also be helpful for creating animated greetings, designing splash screens or loading, upgrading and supplementing online games as well as in other similar cases. 

Our library helps you achieve the desired result in an easy way with as little lines of code as possible.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### How does it work?

GifPlaying:

After an animated picture has been played, the controller managing it closes. And if you want to add a new image, just put it into the project and provide the GIF path as parameter and call method show. 

````swift

@IBAction func showFox(_ sender: Any) {
        AGMobileGiftInterface.show(gifName : "fox")
    }

@IBAction func showRabbit(_ sender: Any) {
        AGMobileGiftInterface.show(gifName : "rabbit")
    }

````

StartGravity:

After we choose a way to initiate animation, just provide view and duration as parameters call the method startGravityView(view: duration: collisionMode:)

````swift

@IBAction startButtonDidTouch(_ sender: Any) {
        self.agGravityService.startGravityView(view: self.view, duration: 10, collisionMode: .everything)
    }

````


### Our examples of animations with AGMobileGiftInterface:

   We’ve used this library when working on Easter greeting program. Quite simple, it has 3 GIF images in its reserve (Ladybird, Rabbit, Fox) but can also be supplemented with new ones. We made example to congratulate the use on the day of Easter.

   Moreover, we have recently supplemented our library with the new interesting animation. In its updated version, our library captures any interface (screen or view) and throws its UI elements over under the influence of gravity, so that one can move them from side to side obliquely. By default, the animation lasts for about 3-4 seconds, but you can adjust its duration at your discretion. After the animation has been completed, all the UI elements returns to their original location.

(Note: We are working with native UI elements (UILabel, UIButton, UIImageView, UISwitch, UISlider, UITExtField, UIProgressView, UITableView/UICollectionView). If listed UI elements embedded in UIView or UIScrollView, library picks it up and animates it separately. We keep on working to handle most intricate interface.)

This animations can be easily used during the development of any application as an event activated after a specified user action.

## Usage

CocoaPods is the recommended way to add AGMobileGiftInterface to your project:
 
1. Add a pod entry for AGMobileGiftInterface to your Podfile pod 'AGMobileGiftInterface'
2. Install the pod(s) by running pod installation.

## Requirements

AGMobileGiftInterface works on iOS 8.0+ and is compatible with ARC projects.
It depends on the following Apple frameworks, which should already be included with most Xcode templates:
You will need LLVM 3.0 or later in order to build “AGMobileGiftInterface”

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

//
//  AGImageStorage.swift
//  Mobile-easter-gift
//
//  Created by Michael Liptuga on 05.04.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

import Foundation
import UIKit
import ImageIO


let DEFAULT_CLARITY :   Float = 0.8

public class AGImageStorage : NSObject
{
    var imageSource             :CGImageSource!
    
    var displayRefreshFactor    :Int = 1
    
    var imageCount              :Int = 1
    
    var displayOrder            :[Int] = [0]
    
    var frameDelay              :Float? = nil

    fileprivate (set) var gifDuration       : Double = 0
    fileprivate (set) var currentClarity    : Float?
    
}

extension AGImageStorage {
    class func createWith (gifData : Data, clarity : Float?, frameDelay : Float?) -> AGImageStorage {
        
        let imageStorage = AGImageStorage()
            imageStorage.imageSource = CGImageSourceCreateWithData(gifData as CFData, nil)
            imageStorage.currentClarity = clarity
            imageStorage.frameDelay = frameDelay

        return imageStorage
    }
    
    var duration                :Double {
        get {
            return self.gifDuration * 0.93
        } set (newDuration)  {
            self.gifDuration = newDuration
        }
    }
    
    var imageSize : Int {
        get {
            let image = UIImage(cgImage: CGImageSourceCreateImageAtIndex(self.imageSource!,0,nil)!)
            return (Int(image.size.height*image.size.width*4) * self.imageCount)/(1000*1000)
        }
    }

    var clarity :Float {
        get {
            guard let clar = self.currentClarity else {
                return DEFAULT_CLARITY
            }
            return (0.1...1).contains(clar) ? clar : DEFAULT_CLARITY
        } set (newClarity) {
            self.currentClarity = newClarity
        }
    }
}

//
//  AGImageViewStorage.swift
//  Mobile-easter-gift
//
//  Created by Michael Liptuga on 05.04.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

import Foundation
import UIKit
import ImageIO

let defaultMemoryLimit : Int = 50

public class AGImageViewStorage : NSObject {
    
    var timer               :CADisplayLink?

    var gifImage            :UIImage!
    var image               :UIImage!

    var displayOrderIndex   :Int!
    var cache               : NSCache<AnyObject, AnyObject>?

    fileprivate (set) var gifMemoryLimit      : Int?

}

extension AGImageViewStorage {
    class func createWith (gifImage : UIImage, memoryLimit : Int?) -> AGImageViewStorage {
        
        let imageViewStorage = AGImageViewStorage()
        
            imageViewStorage.gifImage = gifImage
            imageViewStorage.gifMemoryLimit = memoryLimit
            imageViewStorage.displayOrderIndex = 0
            imageViewStorage.timer = nil
        
        return imageViewStorage
    }
    
    var memoryLimit : Int {
        get {
            return self.gifMemoryLimit ?? defaultMemoryLimit
        } set (newMemoryLimit) {
            self.gifMemoryLimit = newMemoryLimit
        }
    }
    
    var imageCache : NSCache<AnyObject, AnyObject> {
        get {
            if (self.cache == nil) {
                self.cache = NSCache()
                for i in 0..<self.gifImage.imageStorage!.displayOrder.count {
                    let image = UIImage(cgImage: CGImageSourceCreateImageAtIndex(self.gifImage.imageStorage!.imageSource,
                                                                                 self.gifImage.imageStorage!.displayOrder[i],
                                                                                 [(kCGImageSourceShouldCacheImmediately as String): kCFBooleanTrue] as CFDictionary)!)
                    self.cache?.setObject(image, forKey:i as AnyObject)
                }
            }
            return self.cache!
        }
    }
    
    var gifStorage : AGImageStorage {
        get {
            return self.gifImage.imageStorage!
        }
    }
}



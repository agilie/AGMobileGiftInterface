//
//  AGGifImage.swift
//  Mobile-easter-gift
//
//  Created by Michael Liptuga on 10.04.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

import ImageIO
import UIKit

fileprivate let imageStorageKey = malloc(8)

public extension UIImage
{
    
    public convenience init(gifData : Data, clarity : Float?, frameDelay : Float?){
        self.init()
        self.configureImageStorage (gifData : gifData, clarity: clarity, frameDelay: frameDelay)
    }
    
    private func configureImageStorage(gifData : Data, clarity : Float?, frameDelay : Float?){
        
        self.imageStorage = AGImageStorage.createWith(gifData: gifData, clarity: clarity, frameDelay: frameDelay)        
        
        if CGImageSourceGetCount(imageStorage!.imageSource!) > 1 {
            let delayTimes = calculateDelayTimes(imageStorage : imageStorage!)
            self.imageStorage?.duration = Double(delayTimes.reduce(0, +))
            calculateFrameDelay (delaysArray : delayTimes, imageStorage : imageStorage!)
        }
    }
    
    
    fileprivate func calculateDelayTimes(imageStorage: AGImageStorage) -> [Float] {
        guard let imageSource = imageStorage.imageSource else {
            return []
        }
        
        let imageCount = CGImageSourceGetCount(imageSource)
        
        var imageProperties = [CFDictionary]()
        
        if let frameDelay = imageStorage.frameDelay  {
            var frameDelays : [Float] = []
            for _ in 0..<imageCount{
                frameDelays.append(frameDelay)
            }
            return frameDelays
        }
        
        for i in 0..<imageCount{
            imageProperties.append(CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil)!)
        }
        
        var frameProperties = [CFDictionary]()
        
        if (CFDictionaryContainsKey(imageProperties[1],Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque())) {
            //gif type
            frameProperties = imageProperties.map() {
                unsafeBitCast(CFDictionaryGetValue($0,Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()),to: CFDictionary.self)
            }
        } else {
            fatalError("Error: image type.")
        }
        
        let frameDelays:[Float] = frameProperties.map(){
            var delayObject: AnyObject = unsafeBitCast(CFDictionaryGetValue($0, Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()), to: AnyObject.self)
            
            let eps : Float = 1e-6
            
            if(delayObject.floatValue < eps){
                delayObject = unsafeBitCast(CFDictionaryGetValue($0, Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
            }
            return delayObject as! Float
        }
        return frameDelays
    }
    
    fileprivate func calculateFrameDelay (delaysArray : [Float], imageStorage: AGImageStorage){
        if !(delaysArray.count > 0) { return }
        
        var delays = delaysArray
        
        let displayRefreshFactors = [60,30,20,15,12,10,6,5,4,3,2,1]
        
        let maxFramePerSecond = displayRefreshFactors.first
        
        //frame numbers per second
        let displayRefreshRates = displayRefreshFactors.map{ maxFramePerSecond!/$0 }
        
        //time interval per frame
        let displayRefreshDelayTime = displayRefreshRates.map{1.0 / Float($0)}
        
        //caclulate the time when eash frame should be displayed at(start at 0)
        for i in 1..<delays.count {
            delays[i] += delays[i-1]
        }
        
        for i in 0..<displayRefreshDelayTime.count{
            
            let displayPosition = delays.map{ Int( $0/displayRefreshDelayTime[i] )}
            
            var frameLoseCount : Float = 0
            
            for j in 1..<displayPosition.count {
                if (displayPosition[j] == displayPosition[j-1])
                {
                    frameLoseCount += 1
                }
            }
            
            if ( frameLoseCount <= Float(displayPosition.count) * (1.0 - imageStorage.clarity)
                || i == displayRefreshDelayTime.count - 1 ){
                
                imageStorage.imageCount = displayPosition.last!
                
                imageStorage.displayRefreshFactor = displayRefreshFactors[i]
                imageStorage.displayOrder = [Int]()
                
                var oldIndex = 0, newIndex = 1
                
                while (newIndex <= imageStorage.imageCount){
                    if(newIndex <= displayPosition[oldIndex])
                    {
                        imageStorage.displayOrder.append(oldIndex)
                        newIndex += 1
                    } else {
                        oldIndex += 1
                    }
                }
                break
            }
        }
    }
    
    public var imageStorage: AGImageStorage? {
        get {
            return (objc_getAssociatedObject(self, imageStorageKey) as! AGImageStorage)
        }
        set {
            objc_setAssociatedObject(self, imageStorageKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN);
        }
    }
}

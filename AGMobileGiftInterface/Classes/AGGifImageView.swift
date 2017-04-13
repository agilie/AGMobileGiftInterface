//
//  AGGifImageView.swift
//  Mobile-easter-gift
//
//  Created by Michael Liptuga on 10.04.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

import ImageIO
import UIKit

let _imageviewStorageKey = malloc(8)

public extension UIImageView {
    
    public func gif(url: String, memoryLimit : Int?, imageClarity : Float?, frameDelay : Float?, completion : (_ gifDuration : Double, _ errorMessage : String?) -> Void) {
        // Validate URL
        guard let bundleURL = URL(string: url) else {
            print("Gif: This image named \"\(url)\" does not exist")
            completion (0, "Gif: This image named \"\(url)\" does not exist")
            return
        }
        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("Gif: Cannot turn image named \"\(url)\" into NSData")
            completion (0, "Gif: Cannot turn image named \"\(url)\" into NSData")
            return
        }
        self.gif(data: imageData, memoryLimit: memoryLimit, imageClarity : imageClarity, frameDelay : frameDelay, completion : completion)
    }
    
    public func gif(name: String, memoryLimit : Int?, imageClarity : Float?, frameDelay : Float?, completion : (_ gifDuration : Double, _ errorMessage : String?) -> Void) {
        // Check for existance of gif
        
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") ??
            Bundle.main.url(forResource: name, withExtension: "png") else {
                    print("Gif: This image named \"\(name)\" does not exist")
                    completion (0, "Gif: This image named \"\(name)\" does not exist")
                    return
        }
        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("Gif: Cannot turn image named \"\(name)\" into NSData")
            completion (0, "Gif: Cannot turn image named \"\(name)\" into NSData")
            return
        }
        self.gif(data: imageData, memoryLimit : memoryLimit, imageClarity : imageClarity, frameDelay : frameDelay, completion : completion)
    }
    
    public func gif(data: Data, memoryLimit : Int?, imageClarity : Float?, frameDelay : Float?, completion : (_ gifDuration : Double, _ errorMessage : String?) -> Void) {
        // Create source from data
        let image = UIImage.init(gifData: data, clarity: imageClarity, frameDelay : frameDelay)
        self.configure(with: image, memoryLimit: memoryLimit, completion: completion)
    }
    
    public func clearMemory () {
        self.imageViewStorage?.timer?.invalidate()
        self.imageViewStorage?.timer = nil
        self.imageViewStorage = nil
    }
        
    private func configure(with gifImage : UIImage, memoryLimit : Int?, completion : (_ gifDuration : Double, _ errorMessage : String?) -> Void){
        self.imageViewStorage = AGImageViewStorage.createWith(gifImage: gifImage, memoryLimit: memoryLimit)
        
        completion (self.imageViewStorage!.gifStorage.duration, nil)
        guard let imageStorage = self.imageViewStorage?.gifStorage else {
            return
        }
        
        self.imageViewStorage!.image = UIImage(cgImage: CGImageSourceCreateImageAtIndex(imageStorage.imageSource, 0, nil)!)
        
        let updateFrameSelector : Selector = (imageStorage.imageSize >= self.imageViewStorage!.memoryLimit) ? #selector(UIImageView.updateFrameWithoutCache) : #selector(UIImageView.updateFrameWithCache)
        self.imageViewStorage!.timer = CADisplayLink(target: self, selector: updateFrameSelector)
        self.imageViewStorage!.timer!.frameInterval = imageStorage.displayRefreshFactor
        self.imageViewStorage!.timer!.add(to: .main, forMode: RunLoopMode.commonModes)
    }
    
    func updateFrameWithoutCache(){
        self.image = self.imageViewStorage?.image
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async { [weak self] in
            guard let `self` = self else { return }
            guard let imageStorage = self.imageViewStorage else { return }
            imageStorage.image = UIImage(cgImage: CGImageSourceCreateImageAtIndex(imageStorage.gifStorage.imageSource,
                                                                                 imageStorage.gifStorage.displayOrder[imageStorage.displayOrderIndex],
                                                                                 [(kCGImageSourceShouldCacheImmediately as String): kCFBooleanFalse] as CFDictionary)!)
            imageStorage.displayOrderIndex = (imageStorage.displayOrderIndex + 1) % imageStorage.gifStorage.imageCount
        }
    }
    
    func updateFrameWithCache(){
        guard let imageStorage = self.imageViewStorage else { return }
        
        self.image = imageStorage.imageCache.object(forKey: imageStorage.displayOrderIndex as AnyObject) as? UIImage
        if imageStorage.gifStorage.imageCount > 0 {
            self.imageViewStorage!.displayOrderIndex = (imageStorage.displayOrderIndex + 1) % imageStorage.gifStorage.imageCount
        }
    }
    
    fileprivate var imageViewStorage : AGImageViewStorage?{
        get {
            return (objc_getAssociatedObject(self, _imageviewStorageKey) as! AGImageViewStorage)
        }
        set {
            objc_setAssociatedObject(self, _imageviewStorageKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN);
        }
    }
}

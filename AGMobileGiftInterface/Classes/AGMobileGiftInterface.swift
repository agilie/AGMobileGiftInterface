//
//  AGMobileGiftInterface.swift
//  Pods
//
//  Created by Michael Liptuga on 13.04.17.
//
//

import UIKit

public class AGMobileGiftInterface: UIView {

    fileprivate var imageView: UIImageView? = nil
    
    fileprivate var startTime : DispatchTime? = nil
    
    fileprivate var gifFileName : String? = nil
    
    fileprivate var currentViewController : UIViewController? {
        get {
            return UIWindow().visibleViewController
        }
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public class func show (gifName : String)
    {
        let view = AGMobileGiftInterface()
        
        view.frame = UIScreen.main.bounds
        view.backgroundColor = UIColor.clear
        view.gifFileName = gifName
        view.startTime = .now()
        
        if (view.imageView == nil) {
            view.imageView = UIImageView.init(frame: view.frame)
            view.imageView?.contentMode = .scaleAspectFit
            view.addSubview(view.imageView!)
        }
        view.showGif()
    }
    
    fileprivate func showGif() {
        guard let currentGifFileName = self.gifFileName else {
            self.removeView()
            return
        }
        self.currentViewController?.view.addSubview(self)
        self.imageView?.gif(name: currentGifFileName, memoryLimit: 50, imageClarity: 1.0, frameDelay : nil)
        { [weak self] (gifDuration, errorMessage) in
            guard let `self` = self else { return }
            if (errorMessage != nil) {
                self.removeView()
                return
            }
            self.closeViewWith(delay: gifDuration)
        }
    }
    
    fileprivate func removeView () {
        self.removeFromSuperview()
    }
    
    fileprivate func closeViewWith (delay : Double) {
        DispatchQueue.main.asyncAfter(deadline: self.startTime! + delay)
        { [weak self] in
            guard let `self` = self else { return }
            self.imageView?.clearMemory()
            self.removeView()
        }
    }

}

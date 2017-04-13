//
//  ViewController.swift
//  AGMobileGiftInterface
//
//  Created by liptugamichael@gmail.com on 04/13/2017.
//  Copyright (c) 2017 liptugamichael@gmail.com. All rights reserved.
//

import UIKit
import AGMobileGiftInterface

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showFox(_ sender: Any) {
        AGMobileGiftInterface.show(gifName : "fox")
    }
    
    @IBAction func showRabbit(_ sender: Any) {
        AGMobileGiftInterface.show(gifName : "rabbit")
    }

    @IBAction func showLadybird(_ sender: Any) {
        AGMobileGiftInterface.show(gifName : "ladybird")
    }
}


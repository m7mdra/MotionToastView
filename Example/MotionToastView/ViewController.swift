//
//  ViewController.swift
//  MotionToastView
//
//  Created by sameersyd on 08/11/2020.
//  Copyright (c) 2020 sameersyd. All rights reserved.
//

import UIKit
import MotionToastView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func successButt(_ sender: UIButton) {
        MotionToast(title: "نجاح", message: "تمت اضافة المنتج الى السلة بنجاح", toastType: .success,toastGravity: .centre)
    }
    
    @IBAction func errorButt(_ sender: UIButton) {
        MotionToast(title: "Title here", message: "You have failed to complete the trip", toastType: .error, toastGravity: .bottom)
    }
    
    @IBAction func warningButt(_ sender: UIButton) {
        MotionToast(title: "Title here", message: "You are not in the location. Try again", toastType: .warning, duration: .long, toastGravity: .top, toastCornerRadius: 30, pulseEffect: false)
    }
    
    @IBAction func infoButt(_ sender: UIButton) {
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


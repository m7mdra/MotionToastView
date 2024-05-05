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
        title = "MotionToastView"
    }
    
    @IBAction func successButt(_ sender: UIButton) {
        MotionToastManager.shared.show(message: "تمت اضافة المنتج الى السلة بنجاح تمت اضافة المنتج الى السلة بنجاح", toastType: .success, toastGravity: .top)
    }
    
    @IBAction func errorButt(_ sender: UIButton) {
        MotionToastManager.shared.show(title: "Title here", message: "You have failed to complete the trip",
                                       toastType: .error, toastGravity: .bottom)
    }
    
    @IBAction func warningButt(_ sender: UIButton) {
        MotionToastManager.shared.show(title: "Title here", message: "You are not in the location. Try again",
                                       toastType: .warning, duration: .long, toastGravity: .center, toastCornerRadius: 30)
    }
    
    @IBAction func infoButt(_ sender: UIButton) {
        MotionToastManager.shared.show(title: "Title here", message: "You are not in the location. Try again", 
                                       toastType: .noConnection, duration: .long, toastGravity: .top, toastCornerRadius: 30)
    }

    @IBAction func didTapDismissButton(_ sender: Any) {
        MotionToastManager.shared.dismissAll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

}


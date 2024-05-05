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
        MotionToastManager.shared.showSuccess(message: "تم التعديل بنجاح", toastGravity: .top, iconGravity: .leading)
    }
    @IBAction func successButt2(_ sender: Any) {
        MotionToastManager.shared.showSuccess2(title:"تم ارسال الطلب بنجاح", message: "ميك آب ستيشن", toastGravity: .bottom,
                                       toastCornerRadius: 4,
                                       iconGravity: .trailing)
    }
    
    @IBAction func errorButt(_ sender: UIButton) {
        MotionToastManager.shared.showError(title: "Title here", message: "You have failed to complete the trip", toastGravity: .bottom)
    }
    
    @IBAction func warningButt(_ sender: UIButton) {
        MotionToastManager.shared.showWarning(title: "Title here", message: "You are not in the location. Try again")
    }
    
    @IBAction func infoButt(_ sender: UIButton) {
        MotionToastManager.shared.showNoConnection(message: "You are not in the location. Try again")
    }

    @IBAction func didTapDismissButton(_ sender: Any) {
        MotionToastManager.shared.dismissAll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

}


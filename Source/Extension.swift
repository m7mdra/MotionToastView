//
//  Extension.swift
//  MotionToast
//
//  Created by Sameer Nawaz on 10/08/20.
//  Copyright © 2020 Femargent Inc. All rights reserved.
//

import UIKit


extension UIViewController {
    
    public func MotionToast(title: String,message: String, toastType: ToastType, duration: ToastDuration = .short, toastGravity: ToastGravity = .bottom, toastCornerRadius: CGFloat = 30, pulseEffect: Bool = false) {
        
        guard let window = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).map({$0 as? UIWindowScene})
            .compactMap({$0}).first?.windows.filter({$0.isKeyWindow}).first else { return }
        
        var toastDuration = 2.0
        switch duration {
        case .short:
            toastDuration = 2.0
        case .long:
            toastDuration = 4.0
     
        }
        
        let toastView: UIView = toastStyle_pale(title:title,
                                                message: message,
                                                toastType: toastType,
                                                toastGravity: toastGravity,
                                                toastCornerRadius: toastCornerRadius,
                                                view: view,
                                                pulseEffect: pulseEffect);
        
         
        window.addSubview(toastView)
        
        UIView.animate(withDuration: 1.0, delay: toastDuration, options: .preferredFramesPerSecond60, animations: {
            toastView.alpha = 0
            generateHapticFeedback(for: toastType)
        }) { (_) in
            toastView.removeFromSuperview()
        }
    }
    

}
func generateHapticFeedback(for type: ToastType) {
    let generator = UINotificationFeedbackGenerator()
    generator.prepare()
    switch type {
    case .success:
        generator.notificationOccurred(.success)
    case .error:
        generator.notificationOccurred(.error)
    case .warning, .noConnection:
        generator.notificationOccurred(.warning)
        

    }
}


func toastStyle_pale(title: String, message: String, toastType: ToastType, toastGravity: ToastGravity, toastCornerRadius: CGFloat, view: UIView, pulseEffect: Bool) -> MotionToastView {
    
    var gravity = CGRect(x: 0.0, y: view.frame.height - 130.0, width: view.frame.width, height: 83.0)
    switch toastGravity {
    case .top:
        gravity = CGRect(x: 0.0, y: 80.0, width: view.frame.width, height: 83.0)
    case .centre:
        gravity = CGRect(x: 0.0, y: ((view.frame.height / 2) - 41) , width: view.frame.width, height: 83.0)
    case .bottom:
        gravity = CGRect(x: 0.0, y: view.frame.height - 130.0, width: view.frame.width, height: 83.0)
    }
    
    let toastView = MotionToastView(frame: gravity)
    toastView.headLabel.text = title
    toastView.setupViews(toastType: toastType, cornerRadius: toastCornerRadius)
    if pulseEffect { toastView.addPulseEffect() }
    toastView.msgLabel.text = message
    toastView.layer.cornerRadius = toastCornerRadius
    return toastView
}

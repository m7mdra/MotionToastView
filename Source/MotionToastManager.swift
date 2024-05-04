//
//  MotionToastManager.swift
//  MotionToastView
//
//  Created by mega on 04/05/2024.
//

import Foundation

public class MotionToastManager {
    public static let shared = MotionToastManager()
    
    public func show(title: String? = nil, message: String, toastType: ToastType, duration: ToastDuration = .short, toastGravity: ToastGravity = .bottom, toastCornerRadius: CGFloat = 25, pulseEffect: Bool = false) {
        
        guard let window = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0}).first?.windows.filter({$0.isKeyWindow})
            .first else { return }
        guard let view = window.topViewController()?.view else { return }
        var toastDuration = 2.0
        switch duration {
        case .short:
            toastDuration = 2.0
        case .long:
            toastDuration = 4.0
            
        }
        
        let toastView = toastStyle_pale(title:title,
                                        message: message,
                                        toastType: toastType,
                                        toastGravity: toastGravity,
                                        toastCornerRadius: toastCornerRadius,
                                        view: view,
                                        pulseEffect: pulseEffect);
        
        window.addSubview(toastView)
        window.bringSubviewToFront(toastView)
        UIView.animate(withDuration: 0.5, delay: toastDuration, options: .preferredFramesPerSecond60, animations: {
            toastView.alpha = 0
            generateHapticFeedback(for: toastType)
        }) { (_) in
            toastView.dismiss()
        }
        
    
    }
}

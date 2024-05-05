//
//  MotionToastManager.swift
//  MotionToastView
//
//  Created by mega on 04/05/2024.
//

import Foundation

public class MotionToastManager {
    public static let shared = MotionToastManager()
    private var currentToasts: [MotionToastView] = []
    
    public func show(title: String? = nil,
                     message: String,
                     toastType: ToastType,
                     duration: ToastDuration = .short,
                     toastGravity: ToastGravity = .bottom,
                     toastCornerRadius: CGFloat = 25,
                     pulseEffect: Bool = false) {
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
        
        let toastView = createToastView(title:title,
                                        message: message,
                                        toastType: toastType,
                                        toastGravity: toastGravity,
                                        toastCornerRadius: toastCornerRadius,
                                        view: view,
                                        pulseEffect: pulseEffect);
        currentToasts.append(toastView)
        window.addSubview(toastView)
        self.generateHapticFeedback(for: toastType)
        
        toastView.show(withDuration: 0.5)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + toastDuration) {
            toastView.dismiss(withDuration: 0.5) {
                if !self.currentToasts.isEmpty{
                    self.currentToasts.removeFirst()
                }
                toastView.removeFromSuperview()
            }
        }
    }
    

    public func dismissAll() {
        for toastView in currentToasts {
            toastView.dismiss()
        }
        currentToasts.removeAll()
    }
    
    public func dismiss() {
        if let first = currentToasts.first {
            first.dismiss()
            currentToasts.removeFirst()
        }
    }

    private func createToastView(title: String?, message: String, toastType: ToastType, toastGravity: ToastGravity, toastCornerRadius: CGFloat, view: UIView, pulseEffect: Bool) -> MotionToastView {
        
        var gravity = CGRect(x: 0.0, y: view.frame.height - 130.0, width: view.frame.width, height: 83.0)
        switch toastGravity {
        case .top:
            gravity = CGRect(x: 0.0, y: 80.0, width: view.frame.width, height: 83.0)
        case .center:
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
    
    private func generateHapticFeedback(for type: ToastType) {
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
}

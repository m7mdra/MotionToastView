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
    
    public func showError(title: String? = nil, message: String,
                          duration: ToastDuration = .short,
                          toastGravity: ToastGravity = .top,
                          toastCornerRadius: CGFloat = 25,
                          pulseEffect: Bool = false,
                          iconGravity: IconGravity = IconGravity.leading){
        show(title: title,
             message: message,
             toastType: .error,
             toastGravity: toastGravity,
             toastCornerRadius: toastCornerRadius,
             pulseEffect: pulseEffect,
             iconGravity: iconGravity)
    }
    public func showWarning(title: String? = nil, message: String,
                            duration: ToastDuration = .short,
                            toastGravity: ToastGravity = .top,
                            toastCornerRadius: CGFloat = 25,
                            pulseEffect: Bool = false,
                            iconGravity: IconGravity = IconGravity.leading){
        show(title: title,
             message: message,
             toastType: .warning,
             toastGravity: toastGravity,
             toastCornerRadius: toastCornerRadius,
             pulseEffect: pulseEffect,
             iconGravity: iconGravity)
    }
    public func showSuccess(title: String? = nil, message: String,
                            duration: ToastDuration = .short,
                            toastGravity: ToastGravity = .top,
                            toastCornerRadius: CGFloat = 25,
                            pulseEffect: Bool = false,
                            iconGravity: IconGravity = IconGravity.leading){
        show(title: title,
             message: message,
             toastType: .success,
             toastGravity: toastGravity,
             toastCornerRadius: toastCornerRadius,
             pulseEffect: pulseEffect,
             iconGravity: iconGravity)
        
    }
    public func showSuccess2(title: String? = nil, message: String,
                             duration: ToastDuration = .short,
                             toastGravity: ToastGravity = .top,
                             toastCornerRadius: CGFloat = 25,
                             pulseEffect: Bool = false,
                             iconGravity: IconGravity = IconGravity.leading){
        show(title: title,
             message: message,
             toastType: .success2,
             toastGravity: toastGravity,
             toastCornerRadius: toastCornerRadius,
             pulseEffect: pulseEffect,
             iconGravity: iconGravity)
    }
    public func showNoConnection(title: String? = nil, message: String,
                                 duration: ToastDuration = .short,
                                 toastGravity: ToastGravity = .top,
                                 toastCornerRadius: CGFloat = 25,
                                 pulseEffect: Bool = false,
                                 iconGravity: IconGravity = IconGravity.leading){
        show(title: title,
             message: message,
             toastType: .noConnection,
             toastGravity: toastGravity,
             toastCornerRadius: toastCornerRadius,
             pulseEffect: pulseEffect,
             iconGravity: iconGravity)
    }
    
    public func show(title: String? = nil,
                     message: String,
                     toastType: ToastType,
                     duration: ToastDuration = .short,
                     toastGravity: ToastGravity = .top,
                     toastCornerRadius: CGFloat = 25,
                     pulseEffect: Bool = false,
                     iconGravity: IconGravity = IconGravity.leading) {
        
        guard let view = topView() else { return }
        
        let toastView = createToastView(title:title,
                                        message: message,
                                        toastType: toastType,
                                        toastGravity: toastGravity,
                                        toastCornerRadius: toastCornerRadius,
                                        view: view,
                                        pulseEffect: pulseEffect,
                                        iconGravity: iconGravity)
        showToast(toastView: toastView, in: view, duration: duration,toastType: toastType)
        
        
    }
    private func showToast(toastView: MotionToastView, in view:UIView, duration: ToastDuration, toastType: ToastType){
        
        currentToasts.append(toastView)
        view.addSubview(toastView)
        self.generateHapticFeedback(for: toastType)
        
        toastView.show(withDuration: 0.5)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration.rawValue) {
            toastView.dismiss(withDuration: 0.5) {
                if !self.currentToasts.isEmpty{
                    self.currentToasts.removeFirst()
                }
                toastView.removeFromSuperview()
            }
        }
        
    }
    
    private func topView() -> UIView? {
        guard let window = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0}).first?.windows.filter({$0.isKeyWindow})
            .first else { return nil }
        return window.topViewController()?.view
        
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
    
    private func createToastView(title: String?, message: String, toastType: ToastType, toastGravity: ToastGravity, toastCornerRadius: CGFloat, view: UIView, pulseEffect: Bool, iconGravity: IconGravity) -> MotionToastView {
        let frame = calculateFrameFromGravity(toastGravity, view)
        let toastView = MotionToastView(
            frame: frame,
            title: title,
            message: message,
            toastType: toastType,
            iconGravity: iconGravity,
            toastGravity: toastGravity,
            cornerRadius: toastCornerRadius,
            addPulsEffect: pulseEffect)
        return toastView
    }
    
    private func generateHapticFeedback(for type: ToastType) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        switch type {
        case .success, .success2:
            generator.notificationOccurred(.success)
        case .error:
            generator.notificationOccurred(.error)
        case .warning, .noConnection:
            generator.notificationOccurred(.warning)
        }
    }
    
    private func calculateFrameFromGravity(_ toastGravity: ToastGravity,_ view: UIView) -> CGRect{
        
        var gravity = CGRect(x: 0.0, y: view.frame.height - 130.0, width: view.frame.width, height: 83.0)
        switch toastGravity {
        case .top:
            gravity = CGRect(x: 0.0, y: 80.0, width: view.frame.width, height: 83.0)
        case .center:
            gravity = CGRect(x: 0.0, y: ((view.frame.height / 2) - 41) , width: view.frame.width, height: 83.0)
        case .bottom:
            gravity = CGRect(x: 0.0, y: view.frame.height - 130.0, width: view.frame.width, height: 83.0)
        }
        
        return gravity
    }
}

//
//  MTPale.swift
//  MotionToastView
//
//  Created by Sameer Nawaz on 10/08/20.
//  Copyright © 2020 Femargent Inc. All rights reserved.
//

import UIKit

class MotionToastView: UIView {
    
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var circleImg: UIImageView!
    @IBOutlet weak var toastView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        circleView.layer.cornerRadius = circleView.bounds.size.width/2
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        Fonts.loadFonts()
        let bundle = Bundle(for: MotionToastView.self)
        let viewFromXib = bundle.loadNibNamed("MotionToastView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
    
    func addPulseEffect() {
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 1
        pulseAnimation.fromValue = 0.7
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        circleImg.layer.add(pulseAnimation, forKey: "animateOpacity")
    }
    
    func setupViews(toastType: ToastType, cornerRadius: CGFloat) {
        
        toastView.layer.cornerRadius = cornerRadius
        toastView.layer.borderWidth = 1
        
        //TODO: load custom fonts
//        headLabel.font = Fonts.Style.bold.font
//        headLabel.font = Fonts.Style.regular.font

        switch toastType {
        case .success:
            circleImg.image = loadImage(name: "success_icon")
            circleView.backgroundColor = loadColor(name: "success_circle")
            toastView.backgroundColor = loadColor(name: "success_background")
            toastView.layer.borderColor = loadColor(name: "success_circle")?.cgColor

            break
        case .error:
            circleImg.image = loadImage(name: "error_icon")
            circleView.backgroundColor = loadColor(name: "error_circle")
            toastView.backgroundColor = loadColor(name: "error_background")
            toastView.layer.borderColor = loadColor(name: "error_circle")?.cgColor
            break
        case .warning:
            circleImg.image = loadImage(name: "warning_icon")
            circleView.backgroundColor = loadColor(name: "warning_circle")
            toastView.backgroundColor = loadColor(name: "warning_background")
            toastView.layer.borderColor = loadColor(name: "warning_circle")?.cgColor
        case .noConnection:
            circleImg.image = loadImage(name: "no_connection_icon")
            circleView.backgroundColor = loadColor(name: "error_circle")
            toastView.backgroundColor = loadColor(name: "error_background")
            toastView.layer.borderColor = loadColor(name: "error_circle")?.cgColor

            break

        }
    }
    
    func loadImage(name: String) -> UIImage? {
        let podBundle = Bundle(for: MotionToastView.self)
        if let url = podBundle.url(forResource: "MotionToastView", withExtension: "bundle") {
            let bundle = Bundle(url: url)
            return UIImage(named: name, in: bundle, compatibleWith: nil)
        }
        return nil
    }
    
    func loadColor(name: String) -> UIColor? {
        let podBundle = Bundle(for: MotionToastView.self)
        if let url = podBundle.url(forResource: "MotionToastView", withExtension: "bundle") {
            let bundle = Bundle(url: url)
            return UIColor(named: name, in: bundle, compatibleWith: nil)
        }
        return nil
    }
}

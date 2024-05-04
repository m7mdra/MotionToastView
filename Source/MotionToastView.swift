//
//  MTPale.swift
//  MotionToastView
//
//  Created by Sameer Nawaz on 10/08/20.
//  Copyright © 2020 Femargent Inc. All rights reserved.
//

import UIKit

class MotionToastView: UIView {
    var type: ToastType!
    var gravity: ToastGravity!
    var duration: ToastDuration!
    var title: String!
    var message: String!
    
    private lazy var parentView: UIView = {
        let view = UIView()
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(cgColor: CGColor(genericGrayGamma2_2Gray: 0.0, alpha: 0.0))
        return view
    }()
    
    private lazy var toastView: UIView = {
        let view = UIView()
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 0.43529411759999997, green: 0.81568627449999997, blue: 0.58823529409999997, alpha: 0.20000000000000001))
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.contentMode = .scaleToFill
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var circleView: UIView = {
        let view = UIView()
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25

        return view
    }()
    
    private lazy var circleImg: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var headLabel: UILabel = {
        let label = UILabel()
        label.contentMode = .left
        label.text = ""
        label.textAlignment = .natural
        label.lineBreakMode = .byTruncatingTail
        label.baselineAdjustment = .alignBaselines
        label.adjustsFontSizeToFitWidth = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Tajawal-Bold", size: 16)
        label.textColor = UIColor(named: "black_white")
        return label
    }()
    
    lazy var msgLabel: UILabel = {
        let label = UILabel()
        label.contentMode = .left
        label.text = ""
        label.textAlignment = .natural
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        label.baselineAdjustment = .alignBaselines
        label.adjustsFontSizeToFitWidth = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Tajawal-Medium", size: 14)
        label.textColor = UIColor(named: "black_white")
        return label
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        Fonts.loadFonts()
        addSubViews()
        createConstraints()
    }
    
    private func addSubViews(){
        addSubview(parentView)
        parentView.addSubview(toastView)
        toastView.addSubview(stackView)
        toastView.addSubview(circleView)
        stackView.addArrangedSubview(headLabel)
        stackView.addArrangedSubview(msgLabel)
        circleView.addSubview(circleImg)

    }
    
    private func createConstraints(){
        NSLayoutConstraint.activate([
            circleImg.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            circleImg.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            circleImg.widthAnchor.constraint(equalToConstant: 25),
            circleImg.heightAnchor.constraint(equalToConstant: 25),
            
            circleView.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 9),
            circleView.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -9),
            circleView.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 20),
            circleView.centerYAnchor.constraint(equalTo: toastView.centerYAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 45),
            
            stackView.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 15.5),
            stackView.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -15.5),
            stackView.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -20),
            stackView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            
            toastView.topAnchor.constraint(equalTo: parentView.topAnchor),
            toastView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            toastView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            toastView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
            
            parentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            parentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            parentView.heightAnchor.constraint(lessThanOrEqualToConstant: 80),
            parentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10)

            
        ])

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
    
    public func dismiss(){
        removeFromSuperview()
    }
    

    func setupViews(toastType: ToastType, cornerRadius: CGFloat) {
        
        toastView.layer.cornerRadius = cornerRadius
        toastView.layer.borderWidth = 1.5
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

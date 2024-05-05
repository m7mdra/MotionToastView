//
//  MTPale.swift
//  MotionToastView
//
//  Created by Sameer Nawaz on 10/08/20.
//  Copyright © 2020 Femargent Inc. All rights reserved.
//

import UIKit

class MotionToastView: UIView {
    private var iconGravity : IconGravity!
    private var toastGravity: ToastGravity!
    private var toastType: ToastType!
    private var title: String? = nil
    private var message: String!
    private var cornerRadius: CGFloat!
    private var addPulsEffect:Bool = false
    
    private lazy var parentView: UIView = {
        let view = UIView()
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var toastView: UIView = {
        let view = UIView()
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false

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
        label.font = UIFont(name: "Tajawal-Medium", size: 15)
        label.textColor = UIColor(named: "black_white")
        return label
    }()
    
    
    init(frame: CGRect, title: String? = nil, message: String!, toastType: ToastType, iconGravity: IconGravity = .leading, toastGravity: ToastGravity = .top, cornerRadius: CGFloat = 25, addPulsEffect:Bool = false){
        
        super.init(frame: frame)
        self.toastType = toastType
        self.iconGravity = iconGravity
        self.toastGravity = toastGravity
        self.title = title
        self.message = message
        self.cornerRadius = cornerRadius
        self.addPulsEffect = addPulsEffect
        
        commonInit()
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Fonts.loadFonts()
        addSubViews()
        createConstraints()

        setupViews()
        
        
        
        if addPulsEffect{
            addPulseEffect()
        }
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


        switch iconGravity {
        case .leading:
            let circleViewtopAnchor = circleView.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 9)
            circleViewtopAnchor.identifier = "circleViewtopAnchor"
            let circleViewbottomAnchor = circleView.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -9)
            circleViewbottomAnchor.identifier = "circleViewbottomAnchor"
            let circleViewleadingAnchor = circleView.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 20)
            circleViewleadingAnchor.identifier = "circleViewleadingAnchor"
            let circleViewcenterYAnchor = circleView.centerYAnchor.constraint(equalTo: toastView.centerYAnchor)
            circleViewcenterYAnchor.identifier = "circleViewcenterYAnchor"
            let circleViewwidthAnchor = circleView.widthAnchor.constraint(equalToConstant: 45)
            circleViewwidthAnchor.identifier = "circleViewwidthAnchor"
            
            let stackViewtopAnchor = stackView.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 15.5)
            stackViewtopAnchor.identifier = "stackViewtopAnchor"
            let stackViewbottomAnchor = stackView.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -15.5)
            stackViewbottomAnchor.identifier = "stackViewbottomAnchor"
            let stackViewleadingAnchor = stackView.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 16)
            stackViewleadingAnchor.identifier = "stackViewleadingAnchor"
            let stackViewtrailingAnchor = stackView.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -20)
            stackViewtrailingAnchor.identifier = "stackViewtrailingAnchor"
            let stackViewcenterYAnchor = stackView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor)
            stackViewcenterYAnchor.identifier = "stackViewcenterYAnchor"

            NSLayoutConstraint.activate([
                circleImg.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
                circleImg.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
                circleImg.widthAnchor.constraint(equalToConstant: 25),
                circleImg.heightAnchor.constraint(equalToConstant: 25),
                circleViewtopAnchor,
                circleViewbottomAnchor,
                circleViewleadingAnchor,
                circleViewcenterYAnchor,
                circleViewwidthAnchor,
                stackViewtopAnchor,
                stackViewbottomAnchor,
                stackViewleadingAnchor,
                stackViewtrailingAnchor,
                stackViewcenterYAnchor
                
            ])
        case .trailing:
            let circleViewtopAnchor = circleView.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 9)
            circleViewtopAnchor.identifier = "circleViewtopAnchor1"
            let circleViewbottomAnchor = circleView.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -9)
            circleViewbottomAnchor.identifier = "circleViewbottomAnchor1"
            let circleViewtrailingAnchor = circleView.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -20)
            circleViewtrailingAnchor.identifier = "circleViewtrailingAnchor1"
            let circleViewcenterYAnchor = circleView.centerYAnchor.constraint(equalTo: toastView.centerYAnchor)
            circleViewcenterYAnchor.identifier = "circleViewcenterYAnchor1"
            let circleViewwidthAnchor = circleView.widthAnchor.constraint(equalToConstant: 45)
            circleViewwidthAnchor.identifier = "circleViewwidthAnchor1"
            let stackViewtopAnchor = stackView.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 15.5)
            stackViewtopAnchor.identifier = "stackViewtopAnchor1"
            let stackViewbottomAnchor = stackView.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -15.5)
            stackViewbottomAnchor.identifier = "stackViewbottomAnchor1"
            let stackViewleadingAnchor = stackView.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 16)
            stackViewleadingAnchor.identifier = "stackViewleadingAnchor1"
            let stackViewtrailingAnchor = stackView.trailingAnchor.constraint(equalTo: circleView.leadingAnchor, constant: 20)
            stackViewtrailingAnchor.identifier = "stackViewtrailingAnchor1"
            let stackViewcenterYAnchor = stackView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor)
            stackViewcenterYAnchor.identifier = "stackViewcenterYAnchor1"
            
            NSLayoutConstraint.activate([
                circleImg.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
                circleImg.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
                circleImg.widthAnchor.constraint(equalToConstant: 25),
                circleImg.heightAnchor.constraint(equalToConstant: 25),
                circleViewtopAnchor,
                circleViewbottomAnchor,
                circleViewtrailingAnchor,
                circleViewcenterYAnchor,
                circleViewwidthAnchor,
                stackViewtopAnchor,
                stackViewbottomAnchor,
                stackViewleadingAnchor,
                stackViewtrailingAnchor,
                stackViewcenterYAnchor
            ])
        case .none:
            break
        }
        NSLayoutConstraint.activate([
            
            toastView.topAnchor.constraint(equalTo: parentView.topAnchor),
            toastView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            toastView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            toastView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
            
            parentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            parentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            parentView.heightAnchor.constraint(lessThanOrEqualToConstant: 83),
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
    

    private func setupViews() {
        
        toastView.layer.cornerRadius = cornerRadius
        toastView.layer.borderWidth = 1.5
        msgLabel.text = message
        headLabel.text = title
        switch toastType {
        case .success:
            circleImg.image = loadImage(name: "success_icon")
            circleView.backgroundColor = loadColor(name: "success_circle")
            toastView.backgroundColor = loadColor(name: "success_background")
            toastView.layer.borderColor = loadColor(name: "success_circle")?.cgColor
            break
        case .success2:
            circleImg.image = loadImage(name: "success_icon2")
            circleView.backgroundColor = loadColor(name: "success_circle2")
            toastView.backgroundColor = loadColor(name: "success_background2")
            toastView.layer.borderColor = loadColor(name: "success_circle2")?.cgColor
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

        case .none:
            break
        }
    }
    func show(withDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            self.alpha = 1.0
        }, completion: nil)
    }
    
    func dismiss(withDuration duration: TimeInterval, completion: (() -> Void)?) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            self.alpha = 0.0
        }, completion: { _ in
            completion?()
        })
    }
    
    private func loadImage(name: String) -> UIImage? {
        let podBundle = Bundle(for: MotionToastView.self)
        if let url = podBundle.url(forResource: "MotionToastView", withExtension: "bundle") {
            let bundle = Bundle(url: url)
            return UIImage(named: name, in: bundle, compatibleWith: nil)
        }
        return nil
    }
    
    private func loadColor(name: String) -> UIColor? {
        let podBundle = Bundle(for: MotionToastView.self)
        if let url = podBundle.url(forResource: "MotionToastView", withExtension: "bundle") {
            let bundle = Bundle(url: url)
            return UIColor(named: name, in: bundle, compatibleWith: nil)
        }
        return nil
    }
}


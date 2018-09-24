//
//  ThankView.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 30/08/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit

class ThankView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.masksToBounds = true
        layer.cornerRadius = 10
    }
    // MARK: - Gradient
    @IBInspectable var firstColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    @IBInspectable var secondColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var horizontalGradient: Bool = false {
        didSet {
            updateView()
        }
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [ firstColor.cgColor, secondColor.cgColor ]
        
        if (horizontalGradient) {
            layer.startPoint = CGPoint(x: 0.0, y: 0.5)
            layer.endPoint = CGPoint(x: 1.0, y: 0.5)
        } else {
            layer.startPoint = CGPoint(x: 0, y: 0)
            layer.endPoint = CGPoint(x: 0, y: 1)
        }
    }
}

extension UIView {
    func addSubviewWithFadeAnimation(_ view: UIView, duration: TimeInterval, options: UIView.AnimationOptions) {
        view.alpha = 0.0
        addSubview(view)
        UIView.animate(withDuration: duration, delay: 0.0, options: options, animations: {
            view.alpha = 1.0
        }, completion: nil)
    }
    func removeSubviewWithTransform(duration: TimeInterval) {
        UIView.animate(withDuration: duration, delay: 0.0, options: [], animations: {
            //self.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.transform = CGAffineTransform(translationX: 0.0, y: -800)
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
    func removeSubviewWhenPerformSegue(duration: TimeInterval) {
        UIView.animate(withDuration: duration, delay: 0.0, options: [], animations: {
            self.removeFromSuperview()
        }, completion: nil)
    }
}

extension UIColor {
    convenience init? (hexValue: String, alpha: CGFloat) {
        if hexValue.hasPrefix("#") {
            let scan = Scanner(string: hexValue)
            scan.scanLocation = 1
            var hexInt32: UInt32 = 0
            if hexValue.count == 7 {
                if scan.scanHexInt32(&hexInt32) {
                    let red = CGFloat((hexInt32 & 0xFF0000) >> 16) / 255
                    let green = CGFloat((hexInt32 & 0x00FF00) >> 8) / 255
                    let blue = CGFloat(hexInt32 & 0x0000FF) / 255
                    self.init(red: red, green: green, blue: blue, alpha: alpha)
                    return
                }
            }
        }
        return nil
    }
}
